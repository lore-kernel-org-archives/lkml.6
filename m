Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0675EC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BA625B97
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="rpKwP4Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BA625B97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934954AbeF0QBU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:01:20 -0400
Received: from mail-eopbgr700111.outbound.protection.outlook.com ([40.107.70.111]:28175
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934927AbeF0QBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm5+cUM5MiAJGQlLjJF0KuvvvswqxbRI8G5KJvzUNIM=;
 b=rpKwP4CsDrzLp0pDJ4zksDJEdVAfJms/LF7koWGFqai544NTFE0rkHhPX+ELhsaJsywY0Vj9NDhyd97ilZ6rkevLsFqs2UeTXjFnn4a2kEsj+XhlTcf337SW1DGP6X3F6o+VySJCwhOHU8hisy30UPRAp/s6khLJsSvwnRrsYcA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Wed, 27 Jun 2018 16:01:13 +0000
Date:   Wed, 27 Jun 2018 09:01:09 -0700
From:   Paul Burton <pburton@wavecomp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mips: generic: allow not building DTB in
Message-ID: <20180627160109.hvps2lmmte4yibek@pburton-laptop>
References: <20180626115712.11643-1-alexandre.belloni@bootlin.com>
 <20180626115712.11643-2-alexandre.belloni@bootlin.com>
 <20180626140743.GE4207@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626140743.GE4207@piout.net>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR22CA0030.namprd22.prod.outlook.com
 (2603:10b6:300:69::16) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfae748a-8c9a-4627-19c0-08d5dc473535
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:hXscOqxzdElJfUwTui0bxGbJJfEVrDyuBBWXWc17D4raFzmGkWsUa42UwxCbVeJBxKuTKB0yDYIObm6O9ZfKFtvHMCunfW9j6Ych804sSuis50It507bZaQCkjljlOPlvhQDVuz6KtIXCErULqlwWXINwsRYXYnjsspiItYPw2BsdpsYF038n9yuszZRcz1wR/gspM6v5j8a8V4uPUaa6IzmMYSGAOMQcDT2XqqCTeJVzEHe8Wr4bDoZ3MgouI3W;25:KKfBYsklG5ATrpPR3Uz9euk9D0kXhAaFX0QmkcnicLlCkkR/oyTMGZ5CLx6I3g3Xx9NpLvgGjVi+uDMDiJU9gBRczlv+8uKpgehP3dnfYlcHJ/0X7uZyhPterpZLHCrmppXGmhW9gDN49VZiiPYhg13+MoeVuteUEcd6d5Md89EEysUnxE8M/4y5SJom4eHmQpwVt0kqe2DFFkqiDMVxr7G3cmKBUvKVuetR0piJinVw0w7KgaK0g3/5kJCaCMwjbo8/vqZczsUgZRP7OemOEWzexHFt3Z0jKB2LR1ibr5h/E5/w44L5lXDuIy4wkPL/s6nvCUMRS4LhTRwwe2Ahcw==;31:CqXrSQlf9UCqjpSdJ7KPqT18yOcnct+oU66ffk0mYDo7gu3cwuHE8GZ3JQ3QjG03pkgkDKDC5BEjykwM2Hle35fXKkzqEx+rSB414Fym3xkA4OoN+pktRjWfClJhawIPvUhKkB1atyG620QAansltoiV+wRSqdbes+7QP+5VvR2T9AnNzHuG36wMqTtOdPCF5PcYz5AHSmvT6V//kofayyv1c3BjyeWAFH6jcSU4I1A=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:wrn2c4+Kmo9QbCoGJBWVRG7ZlxhQI7sH9cODvfL3qYiVPTrM0VY4o9DJqLMnBRQ//XVgkItUraRMBN7mmJt0aEGWBVp+vYzh31zNbEivRaDqoo5Ih79gAOjwQiI4uOY0JGF+VrF/nsQcXO0cnVzhz5DsriHQI01QIGiBOJJEypkMCpNDSi05ZMefym0bbz5a4Q82ERDq1Y43Sq8lX5ClSZcSmxGIa6h8xSXsXqPbHN2qb/vk9hnNoIFPwofiGBU0;4:dnZvIEXBt+zg94yxee2DZlAApW5Xv6QlFE9JrFn7QlUFmmRIboWAuRRQTECQZ3d6qb7akHT1tIDpFBcvrNV0Nyo6zFzlWfXIYNLDYkZ9WixYaPKmVi+NEFfwfGv+yLbfUsmpnTjl1cKvquadF+aOUJLLC7giX+z7muqDnnSJNuOZlOXW3Ca2GHnkrhXlNf8D4sP5q630B2WMDsm66OGbupauRQA5UwhYI0mWiS+a2k1YaAZ+fWMVkUCzA3xZEx+qLKDEp/aaDw8dmsR9hQFJ2w==
X-Microsoft-Antispam-PRVS: <BN7PR08MB492977A017A9FABC92B2DD1EC1480@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(39840400004)(396003)(376002)(366004)(346002)(199004)(189003)(8676002)(33896004)(76506005)(76176011)(4326008)(33716001)(81156014)(53936002)(105586002)(81166006)(25786009)(50466002)(8936002)(6496006)(6486002)(106356001)(52116002)(6246003)(7736002)(305945005)(386003)(476003)(956004)(5660300001)(6916009)(6666003)(446003)(11346002)(26005)(186003)(16526019)(486006)(54906003)(316002)(68736007)(58126008)(2906002)(16586007)(86362001)(6116002)(3846002)(478600001)(1076002)(23726003)(47776003)(66066001)(14444005)(229853002)(97736004)(9686003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:EpSccCpKqyl0qo39Nr5bHThnqfihUsL5bv/xfl7tz?=
 =?us-ascii?Q?R3B/HMxfR5dXlUuvoxDBS6nKxLfZBRqXRCjRmt/7uct7J9JboDbUsVK4EuXk?=
 =?us-ascii?Q?v0E3HWWxzKTg3hKlThd6Z9lLi4ykQ/XiNuuDMZ42C+9V4sQ7ux6BST+KVnwr?=
 =?us-ascii?Q?c1xMiXAciHM2WsjE2Uo3jxlQGw1zPuJp+PpjsXjrkohmQPoRNOL5EXKLNvoE?=
 =?us-ascii?Q?SjjYzyY4HjfXuAIxDDjJMy8/jRZ5IiyplVZhdzhGJMjCGKmVljkiJw0A4rWn?=
 =?us-ascii?Q?ayHPgVYvPRfFlElQBDnIC1DeojbVoImjJIsexrxuJXMAgG0iIB089nwSceTV?=
 =?us-ascii?Q?UQ0xmIRqPW5FBrPWmSRcJ/HoijHc+TJOEpzEgssOBnOphjE6YdIvgcbjmswK?=
 =?us-ascii?Q?H7BMpoYpyiq7Aa3kxz6BpH+pclCbqMC6oVz73hj7NcXJPArunOEMgGxyzx3p?=
 =?us-ascii?Q?aGQnnGyASpR+gdstF0T6Ddot2R3bCS+Pr3dt4TjMcammDax55bUpot3Z8+cS?=
 =?us-ascii?Q?OmKbt6k9MsgWTb1ajHR5siCPD4S4m/eG9vsmGNOi86TRk8n3WYLxKdqFSCeo?=
 =?us-ascii?Q?RUq7z0KvZ4eVcmOHPMzhTtv2y+ElapKrtI60JdEik73ZWDt6Qe6F2D0zay1C?=
 =?us-ascii?Q?Xg87sBRrDSmIA15F+jEhk5+zVDhzqBScyUwiLn5ehmmDas4y5Ijb6IsyUHTb?=
 =?us-ascii?Q?8fQNLR3tMrR5SnFOjVKaiqxaPMrTwXLv400nOoNWic9NZJv5wJMSDi0G2dNC?=
 =?us-ascii?Q?x/8JCPHTEYNXe1jy58m+lHduGP9MpE3Myih9EXnlUjKE4Al8BDMC/njG4EiY?=
 =?us-ascii?Q?eorA+w7nF3AzT4aAri/2MRByJHaV54lwvDHjWNv/JkcOMS6avpd0EtWBgr7o?=
 =?us-ascii?Q?2aPwR7xhov+N9zJMqHdYgpJFIftR1Gepq/L1ocjnlE6IDuW1zI8tnhtqlxQ8?=
 =?us-ascii?Q?5jPLrDJ0dvn2DUvQ6xnJuFl9P+bGbEOv8vapSrtp1uO1obGPA7KJ+HB1oLBZ?=
 =?us-ascii?Q?+fKtbdcVYHAt5NkC2vuymqGRiGCw/iHHr7vplS4WjZwKzOHx2TI7dkwW3Lpz?=
 =?us-ascii?Q?elnkawHAy1gLKuHEb57ICludJ6CG7rhIhxQ22rXNq5yqxj64c442+LICnbwQ?=
 =?us-ascii?Q?T0KGXwFLPWpn5wRli2sK17Gw8JtZ1pvkA0JSx/SlJaVzK4MXRrLpUFYNw6aI?=
 =?us-ascii?Q?tvzX8aBCMUtpgtg108BMC2/vuoaS5FJQulRdw5try0TAiouCAnMu23aFNb5B?=
 =?us-ascii?Q?mwyJrNf5A9Fw6O/uHEZ1abvEPt3m144UpIPODjgMVZikxtHiHx//n2pC5DqH?=
 =?us-ascii?Q?SFpBM1SLUi6TlWebvC4H8GP6zwbvFULCVGUC2Lvnjb4?=
X-Microsoft-Antispam-Message-Info: 61QxaFqn/tn8XK3Omf1cnvJ1hnnAqpEpSo6eE5nfTDN4qlmxOdtEaQaa8RFPYYt0FKhbNDSycRMn39cGuBb4abZw4mzjLknu14w6OLD7xMEAVlw++yWXP1u338NT8rZJoYu7JQQxwr42TLKJ2xSCSxwYx8vmFalDqdYcgdompsboh01L69S2GQ64G3+NiWJkhTFgu7ZnLXiSg8/rsugzMTTJW4pt3PPv8JXanBapvcODXN6yriv36B2vz9CIdNcTUrFOqETFAaHH+NHRtGL4I3ESYnmHILBbhH1lLV7pnga2DAuKsvXtboO5r1MTtjtyA1/evHYC9XUCLKl1lCBjFL9Vo5zAl5cXe96mdoFaZ1s=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:RsaMCp143nh+Tshr9kgvss1jOn2ErbC3x0yM+xfMgvkvHQhin3uOf9PJPGLgrslxmsPwFbAHZ4ogPBhNSx87vTNiscl6VsD3db/KLp2lnbwHVl0FH7kyBX8/7JW9PGpzHO4YRYdACJP6FCWkcuIPsOlUy8stF6KTWVfBCC+lHavGiDNNw7NYSz2cwV3/GNqMWs4m389K/uFmR1We/V0X+jEVZGu0YdLl3C36jBBUqHfj7BruZqNW7YxvlB7dAsAEzW6UqjAd9t2DAhAVAENj7Sz1tBb3EqbI3ro3FzpzR8tmtogUrizdjOfc/XzTiFLE/upxeKAM0QeS+Vs/lw58MwSZq85iKzcXKtyRuxWvcbAjdBbCJaQvLti9lhX0mz9t5q4vHoky4/LlfhqcEjaowmwOzbQ5ChHnvZFNxbvEpPPi0WowA07v8xKTIaM7RZwbsw5vhG+3ZjFVtqWgUJ9oNg==;5:md3sFg3Zp5LeAUgoKlxiCt+Joufn5qG4rdEQ3SytKrY0qWDA0hRKxmwb3cdumEdZgfpqzZrIxm4vPQjTgrqh/VZHEGF/OE66lct0t7NjFWVi+tzG6TjkCWUbmuS3EB+k7u8MAgSYKfilA8BgKwiO6u2YgI62OcDzJw8JNM+P5cE=;24:4Y5GpunjqgBo1pZhaHGmDPQgj6U0qLwJTInCtZSDgddT8KtqXkjok6YDBqpuI0bUKHvz6/lmYc8Dt2JMOXLJKYnNC/OfyDxMsrCZqPdKifY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;7:Op+f2MDOHo4qU7W5cxPZp8qFHAc3a/J7BvK+SbuBRbOHg0mG/QE4o+Ce5TXkXhfn5VdjphpQ5ra+Q4eLxdPcTtZmjcjCZHKOO1PW9fNDcVm6gIaxp6ZXtIjEffMUPI4bdUbOe5tMMXjyiaHqY0/96w0LltwsXCNe9ADo9bpAno86CAo9fofQyT55tye3VV5ZG17TyMAhoOSFQvAejoLMbTOATUxXhJMjcdPG3oiqhjs3TPGs8AcxnqnNDTFbaf/L
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 16:01:13.3910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfae748a-8c9a-4627-19c0-08d5dc473535
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Tue, Jun 26, 2018 at 04:07:43PM +0200, Alexandre Belloni wrote:
> > diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
> > index 1a08438fd893..9c954f2ae561 100644
> > --- a/arch/mips/generic/vmlinux.its.S
> > +++ b/arch/mips/generic/vmlinux.its.S
> > @@ -21,6 +21,7 @@
> >  		};
> >  	};
> >  
> > +#if IS_ENABLED(CONFIG_BUILTIN_DTB)
> 
> Thinking more about that, the conf@default configuration should probably
> not be removed if the platform is not using DT at all. Are there still
> MIPS platforms without DT support?

There are, but not ones that are supported by the generic platform so we
don't need to worry about those here. We basically have 2 cases to
consider:

  1) FDT as an image within the FIT.

  2) FDT embedded within the kernel binary, ie. legacy boards like
     SEAD-3 (& Malta when I get its port to generic upstreamed).

Case 2 is where conf@default is most useful, since it allows the FIT
image to be loaded (presuming the board has a new enough bootloader)
without the bootloader knowing anything about the FDT. Legacy boards
with the DT built into the kernel then figure out which to use based on
the detect function given in their struct mips_machine.

So I think the most natural #ifdef here might be on
CONFIG_LEGACY_BOARDS, since it would be a little easier to understand at
a glance where the configuration is useful.

Thanks,
    Paul

> >  	configurations {
> >  		default = "conf@default";
> >  
> > @@ -29,4 +30,5 @@
> >  			kernel = "kernel@0";
> >  		};
> >  	};
> > +#endif
> >  };
