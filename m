Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1172C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B03E219E7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bmTP0+Wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B03E219E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933119AbeFUSsP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:48:15 -0400
Received: from mail-ve1eur01on0091.outbound.protection.outlook.com ([104.47.1.91]:34272
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932719AbeFUSsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnMB7DzZD9TTO4EGJaihHqCsySCb76BtLdYQbXLF5ow=;
 b=bmTP0+Wnhe4QQiWnz3fQGlOe0GlLXhsKas2wYvL6RcUCIFjYpvZY9IJxJqqmpllK/7nUVqNbCqrpku6rAmG8fBxPVzcWUY9mFGVc+DxL5yEEVS2l9/3ytK+owpcILcaYPL464qNd1Vy88EKE9yqUdrCM6UTpikojc8qBSXm7nKQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (4.16.175.162) by
 DB7PR08MB3257.eurprd08.prod.outlook.com (2603:10a6:5:1f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Thu, 21 Jun 2018 18:48:07 +0000
Date:   Thu, 21 Jun 2018 11:47:55 -0700
From:   Andrei Vagin <avagin@virtuozzo.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [16/32] kernfs, sysfs, cgroup, intel_rdt: Support fs_context
 [ver #8]
Message-ID: <20180621184754.GB21326@outlook.office365.com>
References: <152720682792.9073.14747437198191460035.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <152720682792.9073.14747437198191460035.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: MWHPR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:301:1::12) To DB7PR08MB3257.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 073f79ea-8b66-431f-5b2a-08d5d7a7886e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:V6jmo+014RghexSabTa5pniiqQ5Fs5Y8+ULOVob8TZLs/wrSYPhDwr5jv6cYlBXtBil/BO225UY/ih3e6Ug1YxpxX3FR5VtkrYozhnTV8imoh6ja3qo31CaU8rhcEQpFb/KFYY+lSxxUc8bm3dFlJcA/VbTD2osLYc/uZSiCCyCXE967bC9o2sJSBcTIR+Qvnjya5utnctHJ8RjfV+IXWFVfXcjHyTxctHDffMxckTQfKBcep+7UvnOLDa04a187;25:dJ2swV5/3IBZt9LRT/z5/f32uWns/Zngx4lEO5UlZY4u1/4Dl5WGjK0WrD1LT7OqoUi3l7EuA2NLY8ih+vclms+PDn3tDjoN5pwqgrjK+pdd1/ifzdQIpuNWpl/+8oUmQ9zWpccT4jWeh1GpdC0vUo+sX6bkq0B3ivvxBoyFTfkn2+7m/jiFOQzzJ65fNCqshhOlSfEkLtop8Hnf1vS95P984QD7a8Q0LK4B1DA6aTo3sO7MVHHdoHhcPZFgVOLe71jSE/XG5H6sa/rt47XBwGJAFhjRZLLp/WsoONnIdVsR82rIRHgujM7lYzfV4VSUJ8Kjz+vrUmbPgBrPCM35AA==;31:mnJ0G/tz1FuZKY8w+MqsnizDx/6ftqQblNU6jDWMziHCWBB5H7dKD6zy0fa5cKUN9vuSfik+t6KITjImw9/uFAPxwlr9T44Z/mwRDw7VQ448fd7NEH/LC0K/VQNX5+PdqpkyutLPgYfmG9+SAFql97Np8Y4wA0dy2uy5cAXRlmJdLyKCB3hywxgXi+9IAAdmcww8TCIUsm6k+37T/FSQkPDLZ2XCMLBfdC2WURByvfA=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:FPMOHIwrl3neN3AGWm8fMhRlJFLtKUYKHRkxWOD0+lioDY600GdhSGwQYKQPoIB8jCj2qBvOORz/wb83SqrpbgzVhgdrStNyu5ePvM3YkmkRJETxO5tLMY2kvmWCQh7srJRN7KGj3N/2RP5MeXnPvqqQiAevG7vBpxXVVxWAx3aU1ACKmI3+Uwobup9OjCo2QUsJ5fbKib2R18UtQ54fZsxLkotk+HWPJQaR9XNli9cNqKSRth7hKhcGMsB1NE3HWeCwK3GSed0GTjWlcvAKOpjNiADyUQWTavKgUmRMQFbl74398cjc3JfO4J2o0enexghXc0Fu1rYNN63seDkcTFJ5Q71PKG0SPKgSTTxXDg1OHYpuEJEVX2lcEwmPCAHweE49mNYQxeBIeZZLejwbM1KbTG7kD79/+ZaXPm/rhpsfpuVuFrtm8n0jWIDwdYKZUVjNc5Y5dL1+9+Pn/LGVgVB5udj0JALWkE/LtShngRjFhKP2lAipS0EadKF+hQzo;4:s0EX6S49/1GN7vp8r+NMWpAd8Ie65sza38KpoJoFTWgeB9Cmbwk+RPFrjBAZwXskXQo2iFnlEwRnPUryBWAkmUStm/SgVPpXd8OBVz4BPA2rI0sWMmzRxhs4cZyx5nYGBE0hfe9FIkt/lYz+WIEh8We6JYBo6mJyUTIh5D6K6gBjKHgT2hRd2fukS/sJAGB6ks1tubpiDXOYpk5pSkmPHhhYlYxoD95vXfY9UpZAIZrUUThLNcSvBmUA31rb5cI6Jsf0e7como4DEkQHaMva2OJQyzOgumnvU8qlvcuT/fyobv82Ww1aJpDxk8LVCv7H
X-Microsoft-Antispam-PRVS: <DB7PR08MB325731BC49ED648259537139CF760@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(251416522907027);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(39850400004)(376002)(199004)(189003)(105586002)(2906002)(486006)(476003)(50466002)(66066001)(956004)(966005)(25786009)(478600001)(6666003)(5660300001)(6916009)(4326008)(33656002)(69596002)(53416004)(47776003)(6306002)(55016002)(106356001)(97736004)(9686003)(23686003)(1076002)(446003)(11346002)(6116002)(68736007)(53936002)(6246003)(3846002)(81156014)(229853002)(8676002)(81166006)(86362001)(52116002)(386003)(6506007)(16526019)(7736002)(7696005)(76176011)(305945005)(26005)(8936002)(58126008)(316002)(575784001)(16586007)(37156001)(186003)(18370500001)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;DB7PR08MB3257;23:UfYSUczik9Lci6vQUqcc1ey4cAJQ2yw0fdsZeArUiqy?=
 =?koi8-r?Q?wIQvsw0npyHHQwFizaSHUmkkwka5NDyT3KErCQyhub5Iy9ZmyC0idoBV8YpIvr?=
 =?koi8-r?Q?tO9OOufpslLK1pby8alYZRtVqxe3QAcn6tzinTJob7SS64nMgA5RISFJK1KjMH?=
 =?koi8-r?Q?0qKFNY2/q5JO+pX757zEsaN9jykzjuS+rTLM8jR54GGXjO5fCoNvpFVKqEClSu?=
 =?koi8-r?Q?90rcCOulJufPlVbpvjVMkflBlNfbkJNEoTtremNletDJLbWEYMYDKMF1kQjqEm?=
 =?koi8-r?Q?RS/2sz7g9n4gSopnk21up0SitWlauAN4Vui58lkqX7kKXuXiXN2n9aAPvzCQNE?=
 =?koi8-r?Q?VZj+ct26CQCycrZOg9bGwVborTClGH91BFWjUAjgmDiyp1e2I2FYWSxLAtWhf2?=
 =?koi8-r?Q?9EzvzRvX7OY7Xu/jQMQ6T2Idp7qE5OOH4ZeGppm2io1bzlzfDAS35IP93ICYUd?=
 =?koi8-r?Q?lcfjpv+ezHjMyxIwKNvt52gufogJvKM/6mjoT4bw68k9Un1/hZsN3OqytNjzhZ?=
 =?koi8-r?Q?US1OyevQ9Ww0u6hZRpdu0z340iCN0Pd9fg8joYmTeYYamq0mxkOjK4UH5LjioU?=
 =?koi8-r?Q?2hVBOuCaKOpwA4Za9Ru27tXabGn9xJC7S2rPKsm4c/+j1gyhIAwIr0BRRJn7tY?=
 =?koi8-r?Q?d7i3tZK0bHQz/vpSPOFTIgxmhCCouDuM5gk4QcS5vW3ovHPHbJcx1qzD4nZ69T?=
 =?koi8-r?Q?vF+3NgzbJy0/PyqFSAOKvU+YrRhJnB976Qn4eFeAZVFHasX4VaFzQq6G6X78sJ?=
 =?koi8-r?Q?bzAJfsuuYaCTjCUaRYErGCO6jZS7yumuonS6KM8DRHGlKpEtIYw4QTUj6vpxNn?=
 =?koi8-r?Q?fhgM3kr2zPotjDzckcvz3B6qCG0z51j+VqMUWrYrUjZ4lHr9wCwvZpGc779UWH?=
 =?koi8-r?Q?FLC5waaPeFPYgd0uLPQ9NbjmffPjhIhqPfPyYumym+BuQaUEhpuDIo0aakod4m?=
 =?koi8-r?Q?AY1xZP9sX8idaadUWfFhhSneAeuH7yKN8n5MpziPoWEEXW3fG8i/8r0Hz0H1eN?=
 =?koi8-r?Q?RSv7jnyx/AqaQezc98Xg0Y2+28ruOVgLdnk3QgAUqMu0IFGKUL14L0Q80Tbu4z?=
 =?koi8-r?Q?pKvtZh1pyoHHcwGQ2Z0z29Y4Hec721UgwsvBa/lRfNmOCvvrymCTjybZ3poTLM?=
 =?koi8-r?Q?Xh7JrgN1IQpc8B5SgHLzDHRoKQ02OUwJhR5vIaBQGL0EzjVD/vMrnf0qMZBF0L?=
 =?koi8-r?Q?kdH4poo8xxluuNiLmWJFMXiEpzaQtARtQ2U6FqigLvxM0IPl8RLfFg8dtZB5b1?=
 =?koi8-r?Q?oVR8LZ9qIjIGHuAQoVvVDB93DciuVlBS2lI0hHy2UkZe+FmSNaRFnLAY0pjKRN?=
 =?koi8-r?Q?IUZYFCEsfckguk8CgrCbxpiGBCbzD8tZAYzvB+DWydUcKXGKfHdnafSqgNmza9?=
 =?koi8-r?Q?R?=
X-Microsoft-Antispam-Message-Info: Nman4TSc+ZTSybvV08R7DuzxCgLVFFKI76fi3g5vAEUVNVi6FUXalaz2t4QfnCevA4DABme1HtGZ0h5RbWngGK3h3kFI7epAOA+N3lx6ErVNSwM1SDXBID7fgk/PrRSW0kt7Bx2ZBZcAiiTQL/RFNGI24NhKlv7onFaRAiCOQQtbIbe+c2ptsWe/BHAInweCKzFcFr7VUxPIvMvLK/1YZdkQln7ngZ0UNtu2hDydhKHe9K35cm1wTicmv1zSLFWUbXnXXERiTxjWJoLWs6fUkfL/h05lR/R+X5GTtet8oeTRD4n3xVAOPiaKTFaI/qz/aD/ZmjjL+9r6UqAKVPs8WQ==
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:UPdyUBtXyh+puMDsoiU291InBE9aUVLx6qcIFLELYTdrigfOuPxWiNnVmTZE2wPl69kB75RuRIljDExK/+n+T2cnTCDBmrcHCfq7r7o+vVwAGdnfX4o/74VUz4ThC9Fg38nsBjetBfc1lOd4RXU5usAlUur6fRk4ecP7sLq6sO5VPIDcwNViSSm/yhnZjZIQypQ9JOtb5djZR1q3S92M+tsR4e78XrKSJCdIpb7zYj9uD3EkG/amLQn6S6DYXdvjD3bz4LHGBUggovS7wCfZB5m1XShPlU9W+pUgQeGFMREoTkyl5BnxLdzMCxXX2f6gGWmRCcRjq4XrUZ7SyzmAFTCVgpvUZRbuiBtdCIjlelLDbvT59OEe0WSzTSCU1zzFNT5GlQo7vPweLDERdlMVNK8b2sV3M1n0KmYRu6h+0pwDdcO2P0KqLF6L5L7fffF79yrhYBU+5X9S2e4QU++I0Q==;5:plGAisYA8xWRTE5OCLWRyj1cyxU4ZS8BBC8aP5CljI7OH1N8TqnSzo8u4CNelgVwdjdULMrh7ZQ2JuCj/8i2KuafJMcT5F1Iknu4pS8tcImc5NHbc+ayv7xDargh4zihGGqN2T39cLU7E7/JzL5YNL8z8XripLs2rVdAcNaJ8LI=;24:8myNAudgB0OPdal1acRqycrJwcbA4jt9oEuDUWdgmnbKzhintxYGulgSAfdF2H8WWMxCmHeTNHGyfWVnEPz14FOzhZ+QnyqkuFWRoNFBhIo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;7:08GII1WFMhrXBTeV9bpKXmmPekycq4w1HnqX7FaSscrAvEWbxk11wsqnLE9YcVf9IWo1eG9ecDPdITTBbj7blX0vRHbLvyY8tvOeV2bdBZwu3iHsPm9O5fcaV9sG+PM7DbF/5EgKGBwwvxsbWAejzU9a9GXd1SXbjTiTwIBJkupz8o/fqgpvsEYpH5jUrMFANhOmZhaVMlgvWbT59qSm5KQggug0/tjMsq1T6WGRL5fLU02Wl0AQ8lpZ0CQuQkz/;20:s0/ekCMdCfl7N71pyxbyXGKNjrfIKQq3rrYpDdy2plkeeeuaYMw9/BR4jFYxG6r3IH16u2mK9797lGvXqFxpsn0QbNg7gKFwpWrn+iZ1eMn2y31tJHT0Fh66S7kFzEmrbbnMIC6U/K70dnsBklcJwJiZ60k8vGMuejLFGYY2Mq4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 18:48:07.8077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 073f79ea-8b66-431f-5b2a-08d5d7a7886e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:07:08AM +0100, David Howells wrote:

...

> @@ -1972,57 +1957,51 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask, int ref_flags)
>  	return ret;
>  }
>  
> -struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
> -			       struct cgroup_root *root, unsigned long magic,
> -			       struct cgroup_namespace *ns)
> +int cgroup_do_get_tree(struct fs_context *fc)
>  {
> -	struct dentry *dentry;
> -	bool new_sb;
> +	struct cgroup_fs_context *ctx = fc->fs_private;
> +	int ret;
> +
> +	ctx->kfc.root = ctx->root->kf_root;

[root@fc24 ~]# mount -t cgroup -o none,name=zdtmtst xxx /mnt/test
[root@fc24 ~]# mkdir /mnt/test/holder
[root@fc24 ~]# umount /mnt/test 
[root@fc24 ~]# mount -t cgroup -o none,name=zdtmtst xxx /mnt/test
Killed

ctx->root can be NULL here

[   93.719897] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[   93.720097] PGD 80000002115f5067 P4D 80000002115f5067 PUD 1ef421067 PMD 0 
[   93.720179] Oops: 0000 [#1] SMP PTI
[   93.720257] CPU: 1 PID: 13843 Comm: cgroup04 Not tainted 4.18.0-rc1-next-20180621+ #1
[   93.720342] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   93.720432] RIP: 0010:cgroup_do_get_tree+0x1b/0xf0
[   93.720515] Code: 00 00 02 5b 5d c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 55 49 89 fc 53 48 83 ec 08 48 8b 9f 90 00 00 00 48 8b 43 20 <48> 8b 00 48 89 03 e8 8a cc 1e 00 85 c0 0f 88 97 00 00 00 48 81 7b 
[   93.720655] RSP: 0018:ffffb07941b03df8 EFLAGS: 00010292
[   93.720740] RAX: 0000000000000000 RBX: ffff9ba3527da300 RCX: 0000000000000000
[   93.720819] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9ba34d47b400
[   93.720897] RBP: ffffb07941b03e58 R08: 0000000000000000 R09: 0000000000000002
[   93.720975] R10: 0000000000000000 R11: 4aee8a3cb0beb9ec R12: ffff9ba34d47b400
[   93.721053] R13: ffff9ba351518000 R14: ffffffff961705d4 R15: ffff9ba35143f000
[   93.721131] FS:  000015418d893740(0000) GS:ffff9ba35fd00000(0000) knlGS:0000000000000000
[   93.721233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   93.721336] CR2: 0000000000000000 CR3: 00000001c4658004 CR4: 00000000001606e0
[   93.721421] Call Trace:
[   93.721508]  cgroup1_get_tree+0x57c/0x640
[   93.721587]  vfs_get_tree+0x6e/0x180
[   93.721665]  do_mount+0x76b/0xa80
[   93.721753]  ksys_mount+0x80/0xd0
[   93.721831]  __x64_sys_mount+0x21/0x30
[   93.721908]  do_syscall_64+0x60/0x1b0
[   93.721987]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   93.722065] RIP: 0033:0x15418d3bc85a

I think we need something like this:

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index e12c0a91b8a4..b1340bd5f5fc 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1192,6 +1192,7 @@ int cgroup1_get_tree(struct fs_context *fc)
                }
 
                ret = 0;
+               ctx->root = root;
                goto out_unlock;
        }
 
@@ -1241,6 +1242,7 @@ int cgroup1_get_tree(struct fs_context *fc)
                percpu_ref_reinit(&root->cgrp.self.refcnt);
                mutex_unlock(&cgroup_mutex);
        }
+       cgroup_get(&root->cgrp);
 
        /*
         * If @pinned_sb, we're reusing an existing root and holding an

https://travis-ci.org/avagin/linux/jobs/394887987

>  
> -	dentry = kernfs_mount(fs_type, flags, root->kf_root, magic, &new_sb);
> +	ret = kernfs_get_tree(fc);
> +	if (ret < 0)
> +		goto out_cgrp;
>  
>  	/*
>  	 * In non-init cgroup namespace, instead of root cgroup's dentry,
>  	 * we return the dentry corresponding to the cgroupns->root_cgrp.
>  	 */
> -	if (!IS_ERR(dentry) && ns != &init_cgroup_ns) {
