Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C75C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7656244D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QK81fTW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7656244D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933870AbeFVPaw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:30:52 -0400
Received: from mail-eopbgr20119.outbound.protection.outlook.com ([40.107.2.119]:46796
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933304AbeFVPau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5sDkOrowZ7p5azamMEy7PNnKltSp+i4E1x4hsELeFY=;
 b=QK81fTW9diSldUjxd9ZHWGosKx49YS+fc0rypD9lsvfj4Zcblp7TS0py9BcPsTyVBrTGzdWoDLJbK0KOAqibrYNTzCbYKKBcuIVARVfZyGHTYRKCGQRaA1W/M9FpVfP6mgU7FhR10Ki/KDhT2sAlY1sSVB3Gy61zDafLWpCcxH8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (73.140.212.29) by
 AM6PR08MB3254.eurprd08.prod.outlook.com (2603:10a6:209:47::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Fri, 22 Jun 2018 15:30:45 +0000
Date:   Fri, 22 Jun 2018 08:30:30 -0700
From:   Andrei Vagin <avagin@virtuozzo.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [16/32] kernfs, sysfs, cgroup, intel_rdt: Support fs_context
 [ver #8]
Message-ID: <20180622153029.GA3070@outlook.office365.com>
References: <20180621184754.GB21326@outlook.office365.com>
 <152720682792.9073.14747437198191460035.stgit@warthog.procyon.org.uk>
 <29799.1529671936@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <29799.1529671936@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:301:2::30) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3015f9f4-d50b-4251-9a29-08d5d8552025
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:G868MiinP8yYcmkBUM/c6QUOZ42LfdftlNugtdesB76Rbx3Jcf3JmbnfrAR/LQ2HPy+U8OMwJgDqyUvFZduuM4mH9D2sJbWZZD1LWhBj71p44XL2QnIkl37L9fkioekfVZJRtrEDksgDp6cSs92WaHeCjme1Yb0nwYBmQQkav5oyQTxXR1ap/AarFhn26eRXEIMfPrSHOMfnA3TGNc8w2QiP+7LKktmuNPCyoLYV0zpBWjAswAEXsZuSGqvu4EAc;25:2OLf30ypB2BcLgq0Xn6rxFMeX++saRUae6ccaL7Rs8SvywcjpPDUA4JhyVX+7fn5MaFWzsh51z7dQltf/94pUVL7Ns+Wk87DK5tnrXI6KR9foVRW2kbaizzCngK8GfXdMCwg6hoFoVqAj51sxS2NAjeQ1eBjVDkCoaF3OrtDLaUYWLWuVoB9c2AEOb2EjvSRlD1gKnawvCMWG+gV0Qn99sAevCa11OA4BFA9YpOregb1+OQ/kzVTkZi/mp8v56TMWaxQS7mJUtKVTLKzlgLdMbSvNTXcE1W2Aq3NlvjmOzWosh4VvRAWWPIKAd4fcnSU+uu2t2w9LUGH3GMM9RQ9wA==;31:Aiyfyarq41XvWDkaumunV3N9lk12xZRWnJCQBXpdKKUe2otXX7TIkgsYH9Y2DTXYr8iWy0Np3BaqR/0yzTRD39WyFTl/dTLIAkBsd+24A4gM8YS+4FQrrRE48Bmg6SxuSdWMd3R26+d95IFYjjHyS5g792Tkeh2hHDgN0zyJXYKvKPJTSIFNySFCaNieK5CYJ8RGc/uU9OMLKd0TNeLa4+TtcWYKRibTd+L4Kk5zk1o=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:bjlUoR2V3BlFduV0UHveUuP6Ls7IDPeM4ZCnX4iRqDNpcj4KxcZGwtKfqGPPvjlE+3Fj1RpUxouaVfB+waBanXxbe5jMge52g5Eks0Fr7R3kUKp3ywRLyzCXsVWlO1lBFDRV8nh+PLjnixCWe+IUFrkK3/ZHfJdvvoUlVdTcXARpBQC8iiDFfZ+wo0gFJnnODJBUTBkBBQab8a/LfCvSJMXltPxGm+SGuDsQX1+DfSrOZQ4qsM9KihXO+D/k5xnPRI7aaL6qOIjO9HilLlgNRE8eD80jLxv7HD++8f0RaGZQKv+V6GgNtl9ZxtBqhvMSnM3TTrfptEbWC7xHnesIHuGG5W/WTVILUl5lJK2qvy0k/alMUoW6EZJdHz0pTGvoB3ry5q/U21nYA1wX7DysRcEk+forXT7d6q6QDPfRVwMz7HDUyrdb8Om/cSs9klbCoWP5ZQFyvPJZe/zpVWjVtmOWAF+Mx6e1yZyXkzJRJLobUUc3u7rzDSO4O/FU6BtM;4:tX3+8PEfSF0yAbKEiQVXebUkaeEJhGg4rKC6ym5zUtDOY9aHJ/rR48FTRboJ0DYKxnAPXOV6LAY62hNafAqi2hrbUB7qDNXZNgcYqEWFc93yxCFMXd0/W7G10UmYIyBLf7W02YEGSW6gyIP/QjVokRWyES88HWr13nEkYsrp6z9YnUCN11ii4htLbXnvOMI9VKVLm1T3rD+K/exlsKnsDSG00Gbom/kAMc1oiHeisX6TYZGIlFh0CkHUUMYY6AXNLLe2Zyf/al7IxbFnA0+F3Q==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3254F79FB196F1C386765384CF750@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39850400004)(396003)(346002)(39380400002)(376002)(199004)(189003)(476003)(11346002)(23686003)(55016002)(316002)(53416004)(16586007)(106356001)(66066001)(33656002)(68736007)(105586002)(1076002)(486006)(6116002)(8936002)(81166006)(6246003)(50466002)(8676002)(3846002)(956004)(446003)(478600001)(53936002)(58126008)(4326008)(229853002)(25786009)(9686003)(81156014)(5660300001)(305945005)(6916009)(26005)(6666003)(69596002)(7736002)(97736004)(6506007)(386003)(76176011)(52116002)(186003)(16526019)(7696005)(47776003)(2906002)(86362001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM6PR08MB3254;23:uqLTvU65hX3F33V8jliyNKaoSDqt63LV5O4SCPeF6yM?=
 =?koi8-r?Q?CwKtnSra1cYLBUlWFrValGcWkdqa4A/jNJtN4i01ne3UiY1f2uCLNbY7xYf1dj?=
 =?koi8-r?Q?O07akvlVCKH0hooJhHgWNdrr0oGlsKgpGG0OwvFvqO/WZzUaT2yDTCm/tNri6Y?=
 =?koi8-r?Q?w7MG6AJjr70hUZZut1VPchaUZQdZkjzrpStQQ580zqL+EfkEY+2+c8jQ/2fbiv?=
 =?koi8-r?Q?DmF10uAZNEKKxwXJZwSjtCfScRKWwYDqr9eAbeBR/XfBZ/DgQonjgBP+/UaXz5?=
 =?koi8-r?Q?g/2C6z/Vi1TyyHbVNNhIJtgGws4S0oYOW9gOGZGF+8qonzryH00zwlmDmBkV4u?=
 =?koi8-r?Q?pCzn8QPxMRg77CjeMn2Z/H521nrebrwvWlq9nzuOt2ihKiJDZBXF8FyeyAk1yJ?=
 =?koi8-r?Q?Dw5Pz5OgRQAXJs3I1ew52I1eIggcsVPKH45JJJeyUSYrNKNt5oEhZ6ruS/YRdT?=
 =?koi8-r?Q?rfTiP39HfDXA1khsGRB5o1rObZLywuqxGUwoalY7aDw5xrEepIJ9U5NZS+2zt4?=
 =?koi8-r?Q?3ods6LvlbOquu0JJnsbzkmHLICqTwYVRwA9CLHvB/xCCjl6yn0D0bDcAfnze63?=
 =?koi8-r?Q?7OpZ4xNeVocW4u8RjrqH3yKik27JOenDRHtnP248y9x2nBBTLioffz1jJRVB+Y?=
 =?koi8-r?Q?gIyjxPCT8ilg/40nrX9of6YZfDO7O2l6LGRWaoni4FNx/kqcbRGaGW9loiodIU?=
 =?koi8-r?Q?EpT6Iz8vzQ5AaodrU4Zd52fLt+MhA2mXBScapd/cKWo5UC7/5nmHWHbd9x/WNE?=
 =?koi8-r?Q?GhOhxh/c+FyFBqMYYTZ3B/pXsN2OUiHURrsxPsLopF2DT+KHkNsD/swLghgc9x?=
 =?koi8-r?Q?Iqh+/z45XBUpCpQJcQ9UWXy5niu2su0EHtVfEMqsqB64ynvM89QppZHS58ukQN?=
 =?koi8-r?Q?qOoujFlrmJrLaYIaR0W1m8pTpeXU/NPt2WWQl5lTy6FdHWf2SY6au6uIlnCWj1?=
 =?koi8-r?Q?RpTSZq0+WW9f8/9FkB/FK1eWUVuTkjbRqjAznZvWwOxyya73PH2825eBTZSu/y?=
 =?koi8-r?Q?sgVQvRq2khQ4gj0QNDJszuEwE7IWM3cIlbk08uMlITI0pk02o5eMxmtd39hcoF?=
 =?koi8-r?Q?MUIqstyBROMr0HYu+4+19B9TDN9EGAOmVh/+a7nQrZQ40TZLL2gNfvH0gIx+/w?=
 =?koi8-r?Q?J4L3CcZJKavQnb189u6ZhEsgbaBUOAC5dQn9J5VGaPL+AiQzlY2T0/uQ8xo0bS?=
 =?koi8-r?Q?o8CXeVi3wHGCyA465nLtgECNokKjIUwfbpPZWAPW3MWxpEVs5Lni1M9eZQ9yP3?=
 =?koi8-r?Q?HY5wlHbBkqi9QH37cdw=3D=3D?=
X-Microsoft-Antispam-Message-Info: gDm3BW6WF7w+waIzR5YeFShrfiwGZ2nZ3dTZIUnKWNvcphV6J6ORUTX0H36iT5QYI88/BDnYpAyf2uVHXnPbZGreDqKCJNfe0OWiiQpFqwuMftoELgIhvFA/UCRUCvfnwXRxoWTj9CDdyYiIkgGn+AgN8Uz01yrrHLn9VL1epnjt3lbGAgdIRLOyPupTdjOlItvvXVKFMGy7hUMgzze0/dUXdU+vLP1MgVzUccq7ShzOo5vltEmMbILIKQkuTiofuh1OErmztDaV2ApAwvu+z3K+Fb1r/YhuMIF9DbOsK9dRf9F+PPlcRfsuSgxzTbJFkHMKOT7xmLSsjq6lnkZXoXBTVLiWTb0z6dO52SCbwfE=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:++fV00sssqNAXcSnQ8l9tTiJE6QKJpjAuxl/E9AIQaDrQu0pDqwtSVor4nBjSbbT6ZWxI7UZXYqcFlnaVgOtWepnwBNA4e8/wJp8E+4jR1H5UyfGlVcUEXRP3hdevDsoM5drHToE16up74z0cvY7sdS0B/3bJD7WvQz0TszVhLAAsjwhDH1JHiR10E2jNjQJM2HPzTeohv8tlTe9AdT7W/wRjRvcloTt2Xrp9O0fKyQ44g2zMf5irKeRoqYG75ecrT0sHRmeEVdhhQo30WX28lp7bjRbThnE2MNiHhBgdk4XjmsT82+5QmA/StFqyP2Nmjsh5nHMKuOnKsWVmRPL7F+VoB3/sqSLE8k5ni/2pgNfqca2GG3l/lm1YuDMI9DLeBQdJMAWMqiKSIo1Qh2ssgIGgkl7nnjt9T/cGiqiuVfV/YreA3EpobuHEE5KOxbvMtduRN3Aet4khIX8K5YKDQ==;5:iXJKjfaGqOEisXYRILeWwsUFZVGVJ0e9d/MJKP5hE5ioH1lK1KZzTiBM0uESl/HZcMvH8Awi1d7qlOjqjVvbk7G6gC3GMdaXsLQ/H0fOxhhg44lCJbjHRLk22Wj1Z4ktfbwNp8EsVpFoAylOWqhtSn8kqNdILUQE5c7l5fXLYyA=;24:6+ESbsL5l8PFgQrQPH5tBzCrj11jIpWwsQgblzRD4+6e8t20XY3I/iWMElSfBbtjsj+MzekRmEq6TxJ35fOGWj+xE4NgiDqmHWBtF1DuVpU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;7:YDOR4ocsxodRUsMh5t5B1Ra3Wl9tYGPFnU5CqNnDI1YxzENqMSRzzePLXShG4G5lLMfQWPmEFvBK2Zxb3hAXNZ9wVcUgLPflVId6wYwx7jsz/E57hpNsIeGfKCvZ1v4b5ecR4rrwKAmYX1VYkz+Tdnc5ITNhJI6K6RpGxnwuKy+hxJ6glVYl4Y8r44y1MPen+X7tEzV5a3xRxdQs5kChVmIeJ4PZioa/EfUY1hvAYxdSeZG+qisQ2mctO5Wt8VdW;20:8Yow8PKZ1jjz4H5gfzicxljy1miwonmCzTp0/n8zfKVopM741SZGFJdIkF6hwcr6JNaS82MofrM7uEizJmJ4duJC6hJsDNfpnM7nC47XHzv2A3qAlQxAsnAtPDXIeHaSsrmsTuhvE53703N5CvbiQMfqn1pNF+aT+VGNbKdk/TU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 15:30:45.0010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3015f9f4-d50b-4251-9a29-08d5d8552025
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:52:16PM +0100, David Howells wrote:
> Andrei Vagin <avagin@virtuozzo.com> wrote:
> 
> >                 ret = 0;
> > +               ctx->root = root;
> >                 goto out_unlock;
> 
> Okay, I can see that.
> 
> >                 percpu_ref_reinit(&root->cgrp.self.refcnt);
> >                 mutex_unlock(&cgroup_mutex);
> >         }
> > +       cgroup_get(&root->cgrp);
> 
> This probably needs to be conditional on ret == 0.

yes, you are right

> 
> Which version are you testing btw?  The patches in git have been fixed a
> little from what was last posted.

I'm testing linux-next-20180621

commit 8439c34f07a3f58245e933ca2703239417288363 (tag: next-20180621,
linux-next/master)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Jun 21 14:09:41 2018 +1000

    Add linux-next specific files for 20180621
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

> 
> David
