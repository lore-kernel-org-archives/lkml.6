Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0A3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89FE208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="amkvfXL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89FE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeHPUV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:21:56 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com ([40.107.4.111]:2534
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728312AbeHPUVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0/Dr7fdRvekrVdhpNlL1aGlByVMmJ8gzF/W997k3Bg=;
 b=amkvfXL4UO0w+fmJcqQGNeUKT7jQDHbvHBiK5+320Wg1U/BBFEXmrjS0nPWnpXBxlbOz4omUn4CYRNLlxatm26UgxnRCpmY9/s4TB0oVhZawsxDVVc2OtaIFXxaz+r2OC/O+YXHo8Ht0Cn9osufpjL7eH/wNpedepLCKLTDNhpY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (4.16.175.162) by
 AM6PR08MB3253.eurprd08.prod.outlook.com (2603:10a6:209:47::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Thu, 16 Aug 2018 17:22:04 +0000
Date:   Thu, 16 Aug 2018 10:21:55 -0700
From:   Andrey Vagin <avagin@virtuozzo.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next] Kernel panic while tetsing criu
Message-ID: <20180816172154.GA28188@outlook.office365.com>
References: <20180816092429.GV10406@uranus.lan>
 <87va8acqkn.fsf@xmission.com>
 <20180816151835.GW10406@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180816151835.GW10406@uranus.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: BN6PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:404:79::28) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3edc699a-569c-42af-f66f-08d6039cca19
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:DnNGqW7lBAl1aXO59I4MaKzLNNgM4htcYJnvFMFB/uHzd5MvH12geHdH9b7qfNofqrp0hgqnrNPQayyQHedwlj/qZcS4f21f+fK/nhytfM1Ap21YdZm8oa/d6QrJrtiFQRVjHHtysUUjtNlV4xHwZb17iM5AoEBTFNF6raSDnQuc6tDQX6mL+hE5FrAwwq2btsBAtCDPl3tWyHpKGuQdjxy9BWCK28rp4DyeqiAKKs+D8pNTXe+vScTwOyXSD9f4;25:9TE5Dl705cZWpmpIL/ULF4eOvOPJZmZJfbgJNg80NdKdA/gGSmYfJZxmYQP4Z7E1Q9Y+1NkUYWcT9j62A1v2dTtf4I1AdF6xTIMcTJYtT+KdD/ZOrsEbueZmku7+/lfHbo62vdNekVoADCBdLi/VdRcHkx47xBw5kdpxW9ei7n5s2DW9qD1+WvDufG+6r97OiAXzgkMSc1XSze+NpNyHesmQ3mGov98K++Uv2PsmeAJFQ8isLGJnuJwhz388k/j1HfGahRDkm+tbFkcySQ565SI7nEflXsr2H3doluvj/Z7V/Sk0x6G26e8LiplveSR9K9b3rYGdkVsKPV2mjTJCxg==;31:8GQE0AXfoiwzhSvdMLUUji0lUh82ts6j9k+bYiRIaMMW/APXlbkW9QbccvIPptV6F/Ol5MmMCfedk8gPZLSOaPbfBLPIqie2BUYfVEnJipVCDbOrKwxFhfntpnuMFl1dwSeNquX6tv52tnJCO0ssIIU13CKeCeCxkuFvK8Pd7NaKrNGcmAswoNFaYi/oDGXMT06aAERrtCncGC6zc2kwQ7ngXGEq1mBJfoI0m8GvsPY=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:8kTs3I+MoYZYpFzEJmAUB/ut6IQcC+Gw6AlCcTU1xK//dvK+Yp4dFf80dvu6Vh/nmsz5qSjYIpacUt5jj/A9+Fas9DboQ20VZu8Im1j6c+YIwXNupjlH/1tjziFM7/+2y6hdJ101FOo5E4halPS84rutNxH33jiyp1R2wIjvOeWlwrnavbqKCDW8zeVGG6JVL+OESgGBYXuGIMNnlryCRM07lXnp/HffSdNfcGVAfWfBcofcqf+uwh8szN4T6x312l8T2qus14WxpNjtyTEzO4eukcoGqCmQUsIYrWqELo/GkdslsJeHvUvA5np2X8PWcZMguyT/1BUGZka2ZzO6WW07Qw+Sxz1mmCU3+fDK0AAE/tPWVLxx6yFQTTSAi9OMkpTkbryJd+nUvVOfc35D2hmDKVOS+xP0wYjY+5w7T0B+KNpURoCpmIsiV+1LPpv1CixHT0KbGEXSHoQ4ARavCs5hl6QUZrF+HUByhQnYpkmsTODNOtZ72IvZLIxdsiAw;4:NsPBRE2imT1wb0hNBKxp5sRhvbVsks5Oi6fJm6gJCHNpoXhyI2FsojBsB+AJ680vV3WFu19WcHa0ePsVhIPKxQlKqE7uNUGidLiYkNQEZlIS1fBhtTJF5HXcyX5xbbWQWalYhhXlmFJeqlkvAIC4wR6UoBFo2bSEkjx7WkcfzhZZ2JRCvLqmb+8PuwNf/Vh0SuJAPOTfd7ScH20w2dnSGvIgeJxwNNco0rlASFJ3P4RrMY9Q4DQZaERYpYevH2Nau9F68stQ4mDUTZl6kIoVsg==
X-Microsoft-Antispam-PRVS: <AM6PR08MB32531E75AAEA151579D9827ACF3E0@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(316002)(8936002)(16586007)(3846002)(66066001)(53936002)(53416004)(6116002)(97736004)(47776003)(105586002)(1076002)(478600001)(106356001)(1411001)(6916009)(14444005)(5660300001)(486006)(6666003)(86362001)(37156001)(16526019)(186003)(76176011)(52116002)(7696005)(6246003)(476003)(33656002)(2906002)(7736002)(386003)(956004)(4326008)(25786009)(39060400002)(69596002)(26005)(23686003)(81156014)(81166006)(54906003)(8676002)(229853002)(50466002)(305945005)(11346002)(55016002)(68736007)(6506007)(9686003)(58126008)(446003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM6PR08MB3253;23:CPqfOiWmXOh0sn82ioWHdW1FNLNwjYhpoJB/jbddJ/P?=
 =?koi8-r?Q?9ZItlWvtcsGlwTMG8ctp+QhlF6egq6JZn/8Y+lsncVx/gUQ3A/5o0pJjrb8WGw?=
 =?koi8-r?Q?2maSWbGIccRDX6i5An9fJBHhJq5wi/EHkSfq/emWfjIwqCoPgeyziZgN90FIwD?=
 =?koi8-r?Q?quQblkRut+Rl5grC2Ba7gmYgVNpSPstsmOaRHaZkvARLrpEE/4enpAXzkIkuUm?=
 =?koi8-r?Q?GKuQzJ99/Vfz96GKc+/DybtiM5JwdoNhn7LxvYLhZDgyk1BQRz+a8R4OpuEaPB?=
 =?koi8-r?Q?kMGkOTRIDdzz+2+QhxHO+bDPghgVSRqyrhyxA5ktLRBPlc7hcaogJpTxvKmd7L?=
 =?koi8-r?Q?x9AmdHjr81ACiHxAT36nrC2/kRrSVR1SzTxz/RQwMVP6B1mhQVgCd79iKjf90H?=
 =?koi8-r?Q?bUlysjD1dUA3eK62fZRLSpqqQuO4+FaH2r7ZOwvVAcxr2919uBqHuB5n9B2wUz?=
 =?koi8-r?Q?YG5G1HmUiSDaPc4fLNIUAUMPsf/C9SizKHkDOP0ksM+5bwf3JoEvQpjD9jYkNc?=
 =?koi8-r?Q?rg4RDVGUdu2YTNlVqrqrY2zd/sdnvNHTcZKPd+lrV4PN7+VVvpEt3aEov2AIfX?=
 =?koi8-r?Q?++BvvlEbt1oZq8oH64MAZgBXmCFT0EXxdqh3ooqVNsgPzdA/dT8zF2R/2wOdQ/?=
 =?koi8-r?Q?9fNvR5Dh6vFrM7q3oHeAEYubeTPi/rI5j8TuMjx3tj2VbrX/P+vRLZ8JkVxFC8?=
 =?koi8-r?Q?KJT7dogOCaYwgBFf9U1mO9678Lap0Jv1Fgi6Sgbleo2pdvfRDNtY3kLegMU1t7?=
 =?koi8-r?Q?BA+bQomRVMCuj5fYgR9UPcwu3hO4ZxArQkHIavKib05hB3fKH3AQ+MA7c8Be7D?=
 =?koi8-r?Q?kbEbnhi67k5MXXgT3jwp2awYlthA/ntP5lVGmpqPZZWcUXMke+hNgGd6/Yr33j?=
 =?koi8-r?Q?ufSrU5DgUhXlheeJUUxawEoDG0qkJojR/0XE29tNXahI84u/5oW1+9LfzV3/nk?=
 =?koi8-r?Q?e9mvOqf8EGUV0sNMfXms4SqvItG+1oArOaoIDq6ggo/7I3orfTHlpbKsVoWuCL?=
 =?koi8-r?Q?BfKzfX5r/8B4egrQdVXuY9iBXMY5vlZXbWLKWBt4duFyyQ2cHPinl2C4vzjTzY?=
 =?koi8-r?Q?VXr9aB2+Eu9VW6HQWY8H5YVwgeqJLs3hIdGqDQNYLY3n6n6Y/4/s6ptl2/yqeo?=
 =?koi8-r?Q?U7nYvky+zVTD5GO+egdwro9M2o2v3tp1EwSN7NYhfwuLe4u/wy+g2V82DHSYSq?=
 =?koi8-r?Q?kd0SJMNzxiC75mSMRpt47oN/hxnTpOocGMPSiZVvY7kW5dBklJCHFOKo0NvMm8?=
 =?koi8-r?Q?JdBummAxQ0KH7ce7hfPiOJbeDXdGTdKKGprxIAk/krUGR2OpXYTzAmXaj+N80C?=
 =?koi8-r?Q?ZZrNCdK0h64kiLsCqcKO621WYJq0fXJekVVqkGF0is=3D?=
X-Microsoft-Antispam-Message-Info: KLTKU9gA8cvAwnmTZB8bCBRm2ei1jzjwSVwdmki+N+5ikujVp2fo/vyvRitwE9+KAUL5lppNXdi1DzunzEKwSrkVD6+HB0jCqXypDwF+FjF6uY8yj2RNcKdVPqbAHVMMji25uxAu4lZ8IflQ1HQ+YAEwPNvdbMrovXrYVeuA+NfyWV1aIuk48RoSCGopDwc4NTJekTS7jfiyh0dxe8X+GDxNuuaq5lH+nilyYbscywtdpZapR2rQQ5/Vyxpp5dO1ecs+27pKg31Z/r8f8GKKdNjzDU7k5liwzGkMv16FuCmSoRw63s2AUfHQG6IuSuhSys3f3LiUoNI76jrVasrL9NCSvNQ6qUVuhRU5YrFIlTg=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:T2t/PI72/4vyMloYOve/Qb8PECxepg5IswiNsCTTxNHftOGYKZDZkjl0UTWJrAiYWWhY01bDmteWRM1+TbGW0ImWUFMHG1KVyecb4h7VOBQB9Ay4Sin+rK01fBXLS/Icou6G9/r2l4sVple6wYeIvf6eR8vzwQ9BnNc15OAiCiQ1ATq41+hy54jPqPHIMyZ1bLFYLXNouVAY94KEVRzk50E+RvDg2TeoxYtfl9jLdlY181OU3+Q+bhPEugxFnESX++1ITAncxAq3O59olQGG7dza58aOPCWGb+zG9/fDKTXae8MIp7geg6m4XT319/NEpLzbJcRkzZhhae6NTioo7VkOA19lFKVg8C0rcEqpRllnQ0PUaDm6yeF3brVw8oN6e9mYiE43TgaQAVabDeqPgx7nfIiORNjrQHdAQrip9ug9LfRLe/BC+pasHO0yKEK68Kx3CLbMHbvSAeF8JFs5Aw==;5:+EDN3ky7jjSwLtGs1W9Fr9GgBiCqplapdDEh4CFtP7VQqq/Qbk3LTcZEweJheDm5edHL+HJr+z2H4aXOlvb+dinZqTmgTFJFClEpCDxo6YoUJ80EqERw1nnQ1RrBFGfdzg9wjlCu3H7pONxSkjqvABMTFC+TkjUkEby7+W5QxwY=;7:VsY3n7iPqZbRTmj9L5AyHqw8WiH1HR6jwLzXS9AbEeQmcY+BTk2uwo9SJHA0fy9oIwLsSXcJn+1MsmRhOWUPilxMnvAmWBY8E9ep94aCQRRSVryjWQglRP+TVSXoUO6fxVHhDUXBX+Zi9lKzsppInJevynvNYrTmGqZ1FTFars8JrC6yRIAVYhpFpwUU92hqOCY4XYzN5aUWTGsdXPodPPOYk0MrmT9lAM7r1WbY5hAcTKGTqRKVBxdBa7T+NoIS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:OkjgkBUbKnTU2KbvGSrQgUzudBLjGCw3WArR+ca3Mk2CP9X16reZymK1yG4Nlr5m40W/FDSMNCL42wlUuNHHIkIVdpW0hlmTlh/nxAmHa/opy+gs5SA0bAOPVTTxuk5vm/IWEk2J6coSSeyBcf0mQdxAmg5F1ZwIyvlM/j5gJQ4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 17:22:04.9497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edc699a-569c-42af-f66f-08d6039cca19
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 06:18:35PM +0300, Cyrill Gorcunov wrote:
> On Thu, Aug 16, 2018 at 09:51:36AM -0500, Eric W. Biederman wrote:
> ...
> > 
> > That patch is incorrect as it misses the rcu_read_unlock.
> > >
> > > p.s. Andrew noticed the problem and asked me to notify,
> > > also he has been testing this oneliner patch. I'm out
> > > of sources at the moment but I think Andrew will help
> > > to test if needed.
> > 
> > I noticed a similar report from syzbot yesterday and I applied the patch
> > below.  Can you verify it fixes your issue?
> 
> I'm quite sure it will help, since the patch is almost doing the same
> as Andrew's fast fix, which checks for @p being nil. But to be sure
> lets wait Andrew to verify.

It fixes the issue.

Thanks,
Andrei
