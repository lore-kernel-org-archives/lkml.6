Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D5FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4012083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UqzmoXKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4012083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937266AbeFSDfO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:35:14 -0400
Received: from mail-eopbgr20125.outbound.protection.outlook.com ([40.107.2.125]:2560
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937206AbeFSDfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjDE9iTacBHFhmxxYoEWePaFTbTcwKw5PV+xFfuReyo=;
 b=UqzmoXKboHLR4Y7kd9xv2ZRDb4tc9cfd8Z+0DwcEPU2dfqgIWlkJ0Ez5zw+ZWGDLj+GJSICwctwTtSZqw/ryaLpPB324E7caedrauWgnZiyX5aQNDaKePagOyiJTWbax3IWRZhaghU68FAzzGIjzQ5YUaJEwngsKCaSctb4Xfoc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (73.140.212.29) by
 AM6PR08MB3253.eurprd08.prod.outlook.com (2603:10a6:209:47::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Tue, 19 Jun 2018 03:35:05 +0000
Date:   Mon, 18 Jun 2018 20:34:51 -0700
From:   Andrei Vagin <avagin@virtuozzo.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [12/24] proc: Add fs_context support to procfs [ver #7]
Message-ID: <20180619033450.GA11639@outlook.office365.com>
References: <152414474815.23902.6952548431423168966.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <152414474815.23902.6952548431423168966.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:300:93::27) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b190068-5242-4d16-5648-08d5d595a6c1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:SePNl5GJOUgez6AEApPPRNoHlr2Lts9626O/O7ivsAPTxLHpuEhyF3qnciH7fbIUe6cStJsTLkfVxLNdZ7lJl1VmbgRiMuLFCtoj4hBxqTZepoMHAp06eufv5juLn0y4H/akcrzOcFFnVTVj0akis3e5yTCrKRErwsrIebjNtpmbp5f91/e1k7FamWbfoms65efoTVHydjaRafTPyLHes8ijEDVXPDqEi9ZCffJedf4PkE96NjdCyHDhB4OnCTcn;25:9tyY1oj2NtQ1BjHqAJiuWhzKv1brsFNmAGz558mkChQCD9jkspN+t6W2tNjeUb7oxi+4Pc8tjhK9UAPvhSWU/i9LB4hrndLApdYSfR8uBEyg3jgLwblODwxnQMw3taMFC+fcvZgFqbHQ3zSeV8YoaMbeF1oGbO2Jt1d4oQQOxMK1mk7/zWlSxtSxZ9UBf7GAv2a1LmUviPTSH/77w8sJr/71oTxuZzE1rjllCqCLsXg32VsBWZcuyc42SLPRvhjfeXNh8Di+2shDMyXqBOmvineZfX8lsH3oGRudX65Ck9M/f/3dpuJynkeAcMUXCb3e1m8pEr5drHObAU5aDDIiDA==;31:yuheOT7Os6gUU8RexHPP1q+jtUwYFTS70HBtvsHOGkjMTBoSpec2EHeYtiozOzFLeuREzJ/ntgQReeqko6GZ3jeYWbmKj7kp7xEndvL/SplgEcx6jiSQgg+jR3UoHt8pJYQtaFaC8iIsePLddldT20D0/y8u7bulk7x/QseioK7UEVoDQcXSJ4B/j4Klgepxjqlbfd5TvJ0egnYS/zMGrntEj8ZTpmvRB6K6GnryjOk=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:Fa/xgzygW5BGDDPwtPhb9NN99AquF2QOV94v8Ng6BU70rru+ioXnrp6Gjj+e4z4eiRbiJeBcwqIdKT2nZi4tuUp2LgZPs7B7JDer1TKfRHUmC7mtPWvcFfZyNN/eP4Lw8KaGbswHKEV1WXenWDAYGAtyb7bdcnDjsX3xOfm+X+BpESzEpZ8k+jy7iUcH8hhmZ4fK4BTERG8ax1vkOoZeRs7vAMAjV+LdRdpZrssUu4yq48LZqYqgFFBpixJOOyni/RtWPvwux09NYNdGAhdCobsNVXnkSrScR4QdXK5cK8iy+g0lwPEzvQ68HQP9GKCO8AcwUR6fPRiCIk3iUzvHphGn8/0IjGzyZs0pRdONLN0X7IsWJyvE9C92E6gC1C5k3WdPGErusNGVsrpbtwI1YkR6Aafv6Ki0HRFFErGzThBjxsm8Cc95+JM1Vg+cWIUj2qxZG9ZWNLJEPoRuhUw45n8uoewKpDe5T0AfQLx9Ifc4IxM+89cUe//Yff3POUZt;4:RSwmi23weV04t8XQ8Vu2t+s9bPoDeZ44nj1d30HvqNLrMrUBlO/wMxSoAWO7KL+5M6j17rO/GN8MCSrg3td/iBHJJrsAqteUInqy21DYmqZA3E0bzzh3zj7GeBmBYrrKA1h1favt8jZUPZjPzG5Sx7oFw0yFv1eWe0SCrzRIJQzyG2zjrvnVA9e/Kg1QM3XMAz/LNPouCfPwczMq2JtrAv3OiIR+UANApprVQnuUVQ1aVtsAWKYtsFjn0WFwlbdPR5eGdhRmdNVQjg3AXlIDxSMa3yjmZPTlzpypEYj1bcfLob0v4ewQL5B4eN6oeHrG
X-Microsoft-Antispam-PRVS: <AM6PR08MB32537D80D6273F44517299F9CF700@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(251416522907027);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39850400004)(376002)(366004)(189003)(199004)(478600001)(966005)(97736004)(33656002)(956004)(446003)(25786009)(476003)(11346002)(512884003)(486006)(316002)(105586002)(106356001)(229853002)(16586007)(58126008)(53416004)(66066001)(55016002)(2906002)(53936002)(6306002)(69596002)(1076002)(2476003)(86362001)(6666003)(9686003)(59450400001)(7696005)(44144004)(6916009)(568964002)(305945005)(81156014)(81166006)(8676002)(7736002)(4610100001)(76176011)(4326008)(68736007)(386003)(8936002)(26005)(5660300001)(5890100001)(186003)(6246003)(84326002)(52116002)(6506007)(3846002)(16526019)(6116002)(18370500001)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3253;23:eJbyDiwC4nm50WekcPoS+WK5zX9rx2+wwzTa9oZLE?=
 =?us-ascii?Q?JsH984RBejhf5BL6BKHeQQKCUAKHK6ThCATlVnEBV0qRrvxTLjlkeOxVFubo?=
 =?us-ascii?Q?4WFtbmD5dUQamz/45U1N6CHLEdgPbw2jMWyr2JQCtr0jnaQvUXmofbdqX/vd?=
 =?us-ascii?Q?7WHB76o7C71sTllG8lOO/h4sdrpHTNT986/UXbVa7LSolMD4WuBni5T/eZ5u?=
 =?us-ascii?Q?Lmo5gvSNcBfEdwXTU8ozgOEZ3tvfMGOsvZRLTavbkZz1x3NZCB3SJmywfiSR?=
 =?us-ascii?Q?y/TFtxPbV9aBz/q9ldLzSPdUAoigHkqKK1G1RCHlIPGYjOSyHo3J/c1n9lYS?=
 =?us-ascii?Q?nAk6S0AJ6Wx/cOoGoZgF//2kbe3kSY/FHo6fD37jd/CSd1NhrReVxVngMLgt?=
 =?us-ascii?Q?xGO86PrM5b71T224eQa43Ru2G6x4/b3QZUlZB3qT6UAbJ1THrKnw5LaT/ycL?=
 =?us-ascii?Q?2gsCW3DVUdF/TqXpBsrVrXOoL/kub7ndTloSytYFqXMS0JXf3fris9LWZC0j?=
 =?us-ascii?Q?0qL50o828x6UTqbcb9x+DudOUf2vh3iyDM/s45ChLm5Xj50a2qDzlgDEM8Ms?=
 =?us-ascii?Q?7Ysbtq+wvG5/w4qlRRqpmWTMehsB/Zs3HYeWsDSibMKQXJBG/Hkn8UBQEiUy?=
 =?us-ascii?Q?b2p27CT0m3n8Pf+6ZURZBuYpyJGFBOvACq+s7CJOkLHbLMaKWB5w8JiEUqEi?=
 =?us-ascii?Q?npOrsxqzpBBLgeollABoZMsTQPrGWiHhhkh6sQejWz9rBzSYnersOZeuAKfq?=
 =?us-ascii?Q?mEeLTwJOu30dHergUvEIUVXN1tJtlzBGhE4IXwfYgsiB5bNU0yPQoRpzbuSe?=
 =?us-ascii?Q?lgvSh1qNdgQHqS4D6bNv3JhBadcOg8aYMCm3tM3CSU9VLQ0DbTh2Tevx+9Jt?=
 =?us-ascii?Q?Dr6314rsMk3GihVL2lHGqAE0KnCugpBBb3WEXZNbiscehHS/xvXyprQXOhLt?=
 =?us-ascii?Q?SSfYoK3sox7DIqr9eqX7+hLQ9aGHyf73FeuGwkObM+7DOKzNxjXd89FFdAg9?=
 =?us-ascii?Q?8z+r7whICtxwMTEE0Erpz1JyrIVS4fHSlZ2l9ZpKTYv++NGI3PK8rt2i0VDV?=
 =?us-ascii?Q?rlTDO2mTeDAfJlC4pclaHs6xEQBUZIhY6yZONBZSqtf/Qa3iomys5P/8fvzO?=
 =?us-ascii?Q?/bVf8OtQZzREy6NF5ZojEcCHq8M2uPZ07fhwYAosKb/hRp/v5gIyFv0nI9gX?=
 =?us-ascii?Q?wWKiMSKxv4/zxMoljorZgocHt4FkD02feQlKE9Gr0wGuhpGf7OrduR815GEt?=
 =?us-ascii?Q?DbT6ZGaeCxqEgqifHvGYkm0v80IozWvElWBJJdJBoilS+O9rr2gCnDjFpm9k?=
 =?us-ascii?Q?xd0dIo7Ggt80tTdntfjVjn6jdLhWwV2yyT4BATzUOt9bg3XdroJXQbRhxoiT?=
 =?us-ascii?Q?vkwavU1aFzUCL775RI+8V12PXt4ey/qQ6pIY+iJIG+hpoULYggczdDYAGcUK?=
 =?us-ascii?Q?ywoFfQZDqumE8nWMuU27gGDQvleqKSQuBXh996cn8PzBClY4Env?=
X-Microsoft-Antispam-Message-Info: hnpXw3Vb+rHkwejnUNabfspQmfPa6Qf1LzIrRBO2KVq5aJmmdIn2EgQumUZ/iTdO4mIhF6Ts1h8LBZ/cr7xbBJ99J6oU0uVO7QdSrpFIUEC3Zci54oCo94fLDMhmjV8dk2Vz5ziCnSe2iIpTKuOaKn1dSvcPmqv61qRIfuvHZIJjDSR37YlgoHO0pl48cjhSG2/pwTOqCq9czVAanAOpxwSEJuobOwKtEWIlt5ulW8iVAzEQyPLMtivjBjj182Akt1kFjwSpb5xj7Co2k4dkdDp+3rdDhvhM3iLeunz/udn9PhpZd4Ewy9q08pP9STkO
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:SWmvs40eidNa2N8hKYLpiyGbZpclt/RTrDZicD/TE4JlTBngJuKWdVls3MHNpTNSEbf3cCfeOwzfBH+e0tvDhLfrIU1WeHvzOTk8+nY9jzO3q2Rd18PmmItXgJDa+xuBY6DTWZHRN3Xyr5bBTA2O4OIt6OJE6Pn8LNl0rniuj9wHs/iPw1I8Mip6H2dyP5NNJc5NkmC5HvAPKDzW2Hk0Qr4hW/aI9vGhFZcUh8BM7k55BGhCIUYF/QOn9h4GcuQr62XLFfK9UXR421CJLmy51cfFlEEXFOaJyCnhBlajPEvdIQPR+rrtqqzKDK8iR2flVhDc97I5qS3PBF8S43q8VL90Dkma3/bS5Um05vSi78jAFHG1dEziqc29/Ru45Au7eI/twMhVZBdmFzRWgnFdt8wRNQymzsAOX+tuc1N09v6/e1pgw6Fc0ebDR1uDKO05daX0qR3UDtS5pkERGLUN9w==;5:1TwxHwM017FMG83huXAIgI2Xo6fkTA4v+C6qQ+gHEnKq6qpY8K5t4CbIm0W3zFcuyT1ZAi7XkE5GTHR5Vtc2r/hqWu8ADaHAj0MKvdMuZbR2unMVRf+uASiX/c3Rs/DE0XTvUwnQNJOzEQgfsWBsCWrM9GRc0ajllC21CVHTzeg=;24:2mVzyrpYjZdoxjg0myTipFcidfl5KZBS2L2/1hlT/yJ9wo88d8HVX+qRcRpS7udeed0pOp/C78CS8wPv66ZDpHctS2DK5tiKUmS46Ky5hjI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;7:2A9EsVtBsKXnRQ1W0auu7+6FALMElVk+D+PUkndSLR6iL2lh1tJZeEdw8p67Wsn35OGIZSqRq4hOqjYHnpCbMCLhP7GZ/gZY72NT4njtFTYzDvMmZD5BuCyEJtdXDA/ActjOPkI0eNOhV04ifvukNlV4cC3PbOApDKnYN2kCdRhceqyIu0G/AIHf8yU1GENGFgbV2VU69tlcUU0yVFAZYsMm1dgiTpktFlpaJUW7XLTVG5+reScDJ+UdNzqIb1vs;20:BrxUWobbSgT4pV8Jy1XiICPuAjssDufBYsBE+HWmBM6qaXtuXNdsOSSBHHIMFea3PVDuCq/0M3MriOdt86ehaKK0EBuM9Mf03viOeorFJdEyRVt4Im0TvmA7pANN6rGpNSsPmdX2v/Lo6RuPgoSP/uqk/jh13kd7y1LlpHdgfXY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 03:35:05.2074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b190068-5242-4d16-5648-08d5d595a6c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi David,

We run CRIU tests for vfs/for-next, and today a few of these test failed. I
found that the problem appears after this patch..

https://travis-ci.org/avagin/linux/jobs/393766778

The reproducer is attached. It creates a process in a new set of namespaces
(user, mount, etc) and then this process fails to mount procfs, the mount
syscall returns EBUSY.

666   pipe([3, 4])                      = 0
666   clone(child_stack=0x7ffc23a89400, flags=CLONE_NEWNS|CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWNET|SIGCHLD) = 667
666   openat(AT_FDCWD, "/proc/667/uid_map", O_WRONLY <unfinished ...>
667   close(4 <unfinished ...>
666   <... openat resumed> )            = 5
666   write(5, "0 100000 100000\n100000 200000 50"..., 36 <unfinished ...>
667   <... close resumed> )             = 0
666   <... write resumed> )             = 36
666   close(5 <unfinished ...>
667   read(3,  <unfinished ...>
666   <... close resumed> )             = 0
666   openat(AT_FDCWD, "/proc/667/gid_map", O_WRONLY) = 5
666   write(5, "0 400000 50000\n50000 500000 1000"..., 35) = 35
666   close(5)                          = 0
666   write(4, " \225\250#", 4)         = 4
667   <... read resumed> " \225\250#", 4) = 4
666   wait4(667,  <unfinished ...>
667   setsid()                          = 1
667   setuid(0)                         = 0
667   setgid(0)                         = 0
667   setgroups(0, NULL)                = 0
667   mount("proc", "/mnt", "proc", MS_MGC_VAL|MS_NOSUID|MS_NODEV|MS_NOEXEC, NULL) = -1 EBUSY (Device or resource busy)

Thanks,
Andrei

On Thu, Apr 19, 2018 at 02:32:28PM +0100, David Howells wrote:
> Add fs_context support to procfs.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/proc/inode.c    |    2 -
>  fs/proc/internal.h |    2 -
>  fs/proc/root.c     |  169 ++++++++++++++++++++++++++++++++++------------------
>  3 files changed, 113 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index 0b13cf6eb6d7..7aa86dd65ba8 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -128,7 +128,7 @@ const struct super_operations proc_sops = {
>  	.drop_inode	= generic_delete_inode,
>  	.evict_inode	= proc_evict_inode,
>  	.statfs		= simple_statfs,
> -	.remount_fs	= proc_remount,
> +	.reconfigure	= proc_reconfigure,
>  	.show_options	= proc_show_options,
>  };
>  
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 3182e1b636d3..a5ab9504768a 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -254,7 +254,7 @@ static inline void proc_tty_init(void) {}
>  extern struct proc_dir_entry proc_root;
>  
>  extern void proc_self_init(void);
> -extern int proc_remount(struct super_block *, int *, char *, size_t);
> +extern int proc_reconfigure(struct super_block *, struct fs_context *);
>  
>  /*
>   * task_[no]mmu.c
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 2fbc177f37a8..e6bd31fbc714 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -19,14 +19,24 @@
>  #include <linux/module.h>
>  #include <linux/bitops.h>
>  #include <linux/user_namespace.h>
> +#include <linux/fs_context.h>
>  #include <linux/mount.h>
>  #include <linux/pid_namespace.h>
>  #include <linux/parser.h>
>  #include <linux/cred.h>
>  #include <linux/magic.h>
> +#include <linux/slab.h>
>  
>  #include "internal.h"
>  
> +struct proc_fs_context {
> +	struct fs_context	fc;
> +	struct pid_namespace	*pid_ns;
> +	unsigned long		mask;
> +	int			hidepid;
> +	int			gid;
> +};
> +
>  enum {
>  	Opt_gid, Opt_hidepid, Opt_err,
>  };
> @@ -37,56 +47,60 @@ static const match_table_t tokens = {
>  	{Opt_err, NULL},
>  };
>  
> -static int proc_parse_options(char *options, struct pid_namespace *pid)
> +static int proc_parse_option(struct fs_context *fc, char *opt, size_t len)
>  {
> -	char *p;
> +	struct proc_fs_context *ctx = container_of(fc, struct proc_fs_context, fc);
>  	substring_t args[MAX_OPT_ARGS];
> -	int option;
> -
> -	if (!options)
> -		return 1;
> -
> -	while ((p = strsep(&options, ",")) != NULL) {
> -		int token;
> -		if (!*p)
> -			continue;
> -
> -		args[0].to = args[0].from = NULL;
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case Opt_gid:
> -			if (match_int(&args[0], &option))
> -				return 0;
> -			pid->pid_gid = make_kgid(current_user_ns(), option);
> -			break;
> -		case Opt_hidepid:
> -			if (match_int(&args[0], &option))
> -				return 0;
> -			if (option < HIDEPID_OFF ||
> -			    option > HIDEPID_INVISIBLE) {
> -				pr_err("proc: hidepid value must be between 0 and 2.\n");
> -				return 0;
> -			}
> -			pid->hide_pid = option;
> -			break;
> -		default:
> -			pr_err("proc: unrecognized mount option \"%s\" "
> -			       "or missing value\n", p);
> -			return 0;
> +	int token;
> +	
> +	args[0].to = args[0].from = NULL;
> +	token = match_token(opt, tokens, args);
> +	switch (token) {
> +	case Opt_gid:
> +		if (match_int(&args[0], &ctx->gid))
> +			return -EINVAL;
> +		break;
> +
> +	case Opt_hidepid:
> +		if (match_int(&args[0], &ctx->hidepid))
> +			return -EINVAL;
> +		if (ctx->hidepid < HIDEPID_OFF ||
> +		    ctx->hidepid > HIDEPID_INVISIBLE) {
> +			pr_err("proc: hidepid value must be between 0 and 2.\n");
> +			return -EINVAL;
>  		}
> +		break;
> +
> +	default:
> +		pr_err("proc: unrecognized mount option \"%s\" or missing value\n",
> +		       opt);
> +		return -EINVAL;
>  	}
>  
> -	return 1;
> +	ctx->mask |= 1 << token;
> +	return 0;
> +}
> +
> +static void proc_set_options(struct super_block *s,
> +			     struct fs_context *fc,
> +			     struct pid_namespace *pid_ns,
> +			     struct user_namespace *user_ns)
> +{
> +	struct proc_fs_context *ctx = container_of(fc, struct proc_fs_context, fc);
> +
> +	if (ctx->mask & (1 << Opt_gid))
> +		pid_ns->pid_gid = make_kgid(user_ns, ctx->gid);
> +	if (ctx->mask & (1 << Opt_hidepid))
> +		pid_ns->hide_pid = ctx->hidepid;
>  }
>  
> -static int proc_fill_super(struct super_block *s, void *data, size_t data_size, int silent)
> +static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>  {
> -	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
> +	struct pid_namespace *pid_ns = get_pid_ns(s->s_fs_info);
>  	struct inode *root_inode;
>  	int ret;
>  
> -	if (!proc_parse_options(data, ns))
> -		return -EINVAL;
> +	proc_set_options(s, fc, pid_ns, current_user_ns());
>  
>  	/* User space would break if executables or devices appear on proc */
>  	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
> @@ -103,7 +117,7 @@ static int proc_fill_super(struct super_block *s, void *data, size_t data_size,
>  	 * top of it
>  	 */
>  	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
> -	
> +
>  	pde_get(&proc_root);
>  	root_inode = proc_get_inode(s, &proc_root);
>  	if (!root_inode) {
> @@ -124,30 +138,46 @@ static int proc_fill_super(struct super_block *s, void *data, size_t data_size,
>  	return proc_setup_thread_self(s);
>  }
>  
> -int proc_remount(struct super_block *sb, int *flags,
> -		 char *data, size_t data_size)
> +int proc_reconfigure(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct pid_namespace *pid = sb->s_fs_info;
>  
>  	sync_filesystem(sb);
> -	return !proc_parse_options(data, pid);
> +
> +	if (fc)
> +		proc_set_options(sb, fc, pid, current_user_ns());
> +	return 0;
>  }
>  
> -static struct dentry *proc_mount(struct file_system_type *fs_type,
> -				 int flags, const char *dev_name,
> -				 void *data, size_t data_size)
> +static int proc_get_tree(struct fs_context *fc)
>  {
> -	struct pid_namespace *ns;
> +	struct proc_fs_context *ctx = container_of(fc, struct proc_fs_context, fc);
>  
> -	if (flags & SB_KERNMOUNT) {
> -		ns = data;
> -		data = NULL;
> -	} else {
> -		ns = task_active_pid_ns(current);
> -	}
> +	ctx->fc.s_fs_info = ctx->pid_ns;
> +	return vfs_get_super(fc, vfs_get_keyed_super, proc_fill_super);
> +}
>  
> -	return mount_ns(fs_type, flags, data, data_size, ns, ns->user_ns,
> -			proc_fill_super);
> +static void proc_fs_context_free(struct fs_context *fc)
> +{
> +	struct proc_fs_context *ctx = container_of(fc, struct proc_fs_context, fc);
> +
> +	if (ctx->pid_ns)
> +		put_pid_ns(ctx->pid_ns);
> +}
> +
> +static const struct fs_context_operations proc_fs_context_ops = {
> +	.free		= proc_fs_context_free,
> +	.parse_option	= proc_parse_option,
> +	.get_tree	= proc_get_tree,
> +};
> +
> +static int proc_init_fs_context(struct fs_context *fc, struct super_block *src_sb)
> +{
> +	struct proc_fs_context *ctx = container_of(fc, struct proc_fs_context, fc);
> +
> +	ctx->pid_ns = get_pid_ns(task_active_pid_ns(current));
> +	ctx->fc.ops = &proc_fs_context_ops;
> +	return 0;
>  }
>  
>  static void proc_kill_sb(struct super_block *sb)
> @@ -165,7 +195,8 @@ static void proc_kill_sb(struct super_block *sb)
>  
>  static struct file_system_type proc_fs_type = {
>  	.name		= "proc",
> -	.mount		= proc_mount,
> +	.fs_context_size	= sizeof(struct proc_fs_context),
> +	.init_fs_context	= proc_init_fs_context,
>  	.kill_sb	= proc_kill_sb,
>  	.fs_flags	= FS_USERNS_MOUNT,
>  };
> @@ -205,7 +236,7 @@ static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentr
>  {
>  	if (!proc_pid_lookup(dir, dentry, flags))
>  		return NULL;
> -	
> +
>  	return proc_lookup(dir, dentry, flags);
>  }
>  
> @@ -259,9 +290,31 @@ struct proc_dir_entry proc_root = {
>  
>  int pid_ns_prepare_proc(struct pid_namespace *ns)
>  {
> +	struct proc_fs_context *ctx;
> +	struct fs_context *fc;
>  	struct vfsmount *mnt;
> +	int ret;
> +
> +	fc = vfs_new_fs_context(&proc_fs_type, NULL, 0,
> +				FS_CONTEXT_FOR_KERNEL_MOUNT);
> +	if (IS_ERR(fc))
> +		return PTR_ERR(fc);
> +
> +	ctx = container_of(fc, struct proc_fs_context, fc);
> +	if (ctx->pid_ns != ns) {
> +		put_pid_ns(ctx->pid_ns);
> +		get_pid_ns(ns);
> +		ctx->pid_ns = ns;
> +	}
> +
> +	ret = vfs_get_tree(fc);
> +	if (ret < 0) {
> +		put_fs_context(fc);
> +		return ret;
> +	}
>  
> -	mnt = kern_mount_data(&proc_fs_type, ns, 0);
> +	mnt = vfs_create_mount(fc);
> +	put_fs_context(fc);
>  	if (IS_ERR(mnt))
>  		return PTR_ERR(mnt);
>  

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="test.c"

#define _GNU_SOURCE
#include <sys/types.h>
#include <sched.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/mount.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <grp.h>
#include <linux/limits.h>


#define NS_STACK_SIZE	4096

#define __stack_aligned__	__attribute__((aligned(16)))

/* All arguments should be above stack, because it grows down */
struct ns_exec_args {
	char stack[NS_STACK_SIZE] __stack_aligned__;
	char stack_ptr[0];
	int pfd[2];
};

static int ns_exec(void *_arg)
{
	struct ns_exec_args *args = (struct ns_exec_args *) _arg;
	int ret;

	close(args->pfd[1]);
	if (read(args->pfd[0], &ret, sizeof(ret)) != sizeof(ret))
		return -1;

	setsid();

	if (setuid(0) || setgid(0) || setgroups(0, NULL)) {
		fprintf(stderr, "set*id failed: %m\n");
		return -1;
	}

	if (mount("proc", "/mnt", "proc", MS_MGC_VAL | MS_NOSUID | MS_NOEXEC | MS_NODEV, NULL)) {
		fprintf(stderr, "mount(/proc) failed: %m\n");
		return -1;
	}

	return 0;
}

#define UID_MAP "0 100000 100000\n100000 200000 50000"
#define GID_MAP "0 400000 50000\n50000 500000 100000"
int main()
{
	pid_t pid;
	int ret, status;
	struct ns_exec_args args;
	int flags;
	char pname[PATH_MAX];
	int fd, pfd[2];

	if (pipe(pfd))
		return 1;

	args.pfd[0] = pfd[0];
	args.pfd[1] = pfd[1];

	flags = CLONE_NEWPID | CLONE_NEWNS | CLONE_NEWUTS |
		CLONE_NEWNET | CLONE_NEWIPC | CLONE_NEWUSER | SIGCHLD;

	pid = clone(ns_exec, args.stack_ptr, flags, &args);
	if (pid < 0) {
		fprintf(stderr, "clone() failed: %m\n");
		exit(1);
	}


	snprintf(pname, sizeof(pname), "/proc/%d/uid_map", pid);
	fd = open(pname, O_WRONLY);
	if (fd < 0) {
		fprintf(stderr, "open(%s): %m\n", pname);
		exit(1);
	}
	if (write(fd, UID_MAP, sizeof(UID_MAP)) < 0) {
		fprintf(stderr, "write(" UID_MAP "): %m\n");
		exit(1);
	}
	close(fd);

	snprintf(pname, sizeof(pname), "/proc/%d/gid_map", pid);
	fd = open(pname, O_WRONLY);
	if (fd < 0) {
		fprintf(stderr, "open(%s): %m\n", pname);
		exit(1);
	}
	if (write(fd, GID_MAP, sizeof(GID_MAP)) < 0) {
		fprintf(stderr, "write(" GID_MAP "): %m\n");
		exit(1);
	}
	close(fd);

	if (write(pfd[1], &ret, sizeof(ret)) != sizeof(ret))
		return 1;

	if (waitpid(pid, &status, 0) != pid)
		return 1;
	if (status)
		return 1;

	return 0;
}

--82I3+IH0IqGh5yIs--
