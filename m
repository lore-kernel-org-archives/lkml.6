Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139CDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2620265FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iujoaY17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2620265FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeFZH2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:28:06 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:24313
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751569AbeFZH2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6KbT7ywntiQKbMM8wA0M2fNMb/J9QNvPFOXu5E+18U=;
 b=iujoaY17xPa9zzM57bYoCLzXUgSoWAW0vwY9KbHGa4V+GpWt/8whx9c5SvBZ+hWToW10BUi45+HchpRPXJdSL0xpRmmsleiNPyX3wEeNH+coDMlFyXcqjY4DlFDGhEX39sJ6AaIp/iiPfGOooG7NKpbPpd1OwysN4/CATUTec4c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (73.140.212.29) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Tue, 26 Jun 2018 07:27:56 +0000
Date:   Tue, 26 Jun 2018 00:27:38 -0700
From:   Andrei Vagin <avagin@virtuozzo.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [12/24] proc: Add fs_context support to procfs [ver #7]
Message-ID: <20180626072736.GA31860@outlook.office365.com>
References: <152414474815.23902.6952548431423168966.stgit@warthog.procyon.org.uk>
 <20180619033450.GA11639@outlook.office365.com>
 <20180626061320.GA12548@outlook.office365.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20180626061320.GA12548@outlook.office365.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:301:3b::23) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c948e69-859b-4ac0-60f7-08d5db36572c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:/AfDY4ot1Wwcn4lT4eGlBW1zQzJn6uGg7MauB4Q7mLNYole4JpgtKNZxIpVGb0H2fDko+vR020DvdgmhbLxjuojIZkfDA693sDl5Dy6ymmGbS3zPCG3b57pJdbxJVZ6LzS7LmwjWfPm76rV81gZ6mVkr12j3XPyV6gZGNvhOEsvRZ9yf6TVxc69aqtrfFd1nYPIEdfwvXTGs9Dkzl8YMO3ZuH1jXwoehh+W5cuo/GnKeBpdjd+g1n/QGauNj4ADE;25:z2ui+8bQn6bZwXFl0HFFSqZ8DRmxS4JzfJdQk/71sR6v7DVhNR8Re54GqXbGo0qjFuQ+iEey+cJXPGBEl9AFcPGEBLyjGRMDHNgsqNK2aRP1py5LwaxkrGMZlrXec6VpJWQOSbd/Ostm/1jJSKU5VZKEtnk99vsq2+mi2HkHFL+ZlLq9E9srbu/MZx76+5Fr4WQefZv4RFD8N/9mcjYh/oPpjx1aqqH6rttOScL2/y0WiXX00A0Hji66y+6RAkLop3ahID6YWSh3NbL8GiXLMyty8aqQ3Gy07wMoO1yvxgUXk8fwTEKEXG/fx7CJhJIdKOtdTGrFf/f8Q262Vk4WlQ==;31:SiduPQm44kmvSQvUfai/X/rHyrPQ1RfkZXlNJqUf2ygS3ZCRO16/0vJRzvW+RVQIlvkdZip2KqmLdGrROUPFilpEZVLrV7TlCz8067jxWei0nJCnZCY97nuIJOWOECFzH+zLuECov25BCgu82yD5DAhtuzQPCQoeEQPYEmtiyXaZ/vMhRW5iMamn8gxT/7aUreGxuBZYKF1YWwRaHAFdQ7u2+gYYFe5DRSmuj34CFl8=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:UYhxeO+pFhxV/YJO2Wi+RBKgStuQFL+fhIY4qqVr899+gsY0xRwPcK5hU6RKS61OJ9RBoqH/Uh7ll/76RGYlpvBJ6/QZfaWQWpk8gRdfQ6IMgwma90/AcZC9cMtF0yWaMzDK+6qJGtXSpdC6HZhJptjNqM5UQNyOla/577F0TRaLdS9vUsWb8SOgWEt2o1HdHuEgv/l7kIYpPYNrdd6BwxPu4lmQLn2hV+ZVgWPj7d77JDmGovE1SOtIU9iTxFuvp8k7S4lw83BghCBESMC5TbMHEkcPSB32/90aF1e3uwo8BzuWTjv1skWUoAT8yL1rpVM/8fOGKM1vpjYtaRmDKKzueRmw6iIoZGCWKgP5r70mxuewPhi2YZ9Pp+msLnJrtVV15U2TWi9yZ3pQANIBukNHp+5j6EeFnhqfFjnHGKvnp0PmG3a/wZ/uhSDXAQ19Itt+A2jl9J5OlXKpBRkcDspbiho4tqKLe/wwnYAVt/pxJZJhEgemXa7UET8+0PGA;4:m6SzirFDC+lo/f2dsnRUU1js/Pqry06NdJlSqkBplJXKGhbQ2ivsILIMfGHPXbq6QG5S+FSnixdKHekXROiNyFaHPBScjc4mvEU2Jv1x/xfMVTjH0QG+eBK8yDmTMvsDWdRfK5cSHfJJoxBYnCE5l8rqjGaVfpuJesVG1L4DGZjPpEvzMdsC/Jp8dbFahekjWPLz9TiGV9y4rLoJ56Zq/lOCOIOEnsYhAng3rwUVZV4Fqu6gCNlbf2ioJxKQo+3F+DIsQvQSoTIY9c+bE3kBXQ==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3258EFA1C706F609854D3DCACF490@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(39850400004)(396003)(199004)(189003)(68736007)(106356001)(5660300001)(105586002)(568964002)(6666003)(81156014)(8676002)(25786009)(8936002)(4610100001)(81166006)(305945005)(14444005)(5024004)(97736004)(16586007)(2906002)(316002)(33656002)(84326002)(58126008)(7736002)(4326008)(6916009)(26005)(229853002)(476003)(53416004)(1076002)(11346002)(6246003)(486006)(86362001)(66066001)(512884003)(76176011)(69596002)(6506007)(386003)(2476003)(478600001)(956004)(9686003)(16526019)(3846002)(186003)(446003)(55016002)(6116002)(44144004)(7696005)(52116002)(53936002)(18370500001)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3258;23:XAmS6b3CNTmNiV10Drcky1wqCVu46AnIf07gGPEym?=
 =?us-ascii?Q?cgwo7ruGe8AFdRwjaRqFnjs5w3MrZHbphwO2XQjzlA4ile98U0nE5VZ/2aBH?=
 =?us-ascii?Q?vTXFJrt0Nq1A2UxkwuhruVEWWJd1L78N3RK18bauMEI6fsyPauFDHEMWDPup?=
 =?us-ascii?Q?CtwkrAqnGT6b1S/Up1WPTdjrW5OYsrrOlR9FC900rQAdaHueAw5sTHjSmvM0?=
 =?us-ascii?Q?tMv4HF/RNdCLn1+hnaHc9Qqu38lIS/Uh4e3Dc5D5EOwNpxONtQctFXPAPS7U?=
 =?us-ascii?Q?geZ8iB4dcCW4lp8DhGTwIjUY8+DQlysw0ANXEfqED0R6G0F5fKNDeUtuxTo1?=
 =?us-ascii?Q?MYiR9cbqan0lT0v0FjiF+UIRplWW3luFmRhjQEvhPF4qIMuCXSoo69NPURuq?=
 =?us-ascii?Q?/k457bA1YT31iIhELmaFIEVkABRjlfFUwU+MhnRMmq1bnCHjef5nPEW6yBEQ?=
 =?us-ascii?Q?PR7zyuvWoeBo59nHyWDffoMD672DKx34dWGk0FXdq6RtKvxGQpRLCiYOF4QU?=
 =?us-ascii?Q?XTSA5AAJXGXkG/OVuzSxh6jKfoyajKbNz3JPNXFdglAtshGY2QJtV7xh3Ng/?=
 =?us-ascii?Q?+k9+H0XhJCH9ShM3zOz9xgNGPPpttPTkW9HKhn1qwDTttjydw1sCA3h0hVnR?=
 =?us-ascii?Q?OJAvP6w11PSDtBU6JJ/YNCSmASITZVD1G8AFxImRtYhm4hXROrQEgdCgxDDf?=
 =?us-ascii?Q?wNJVpg3WlxUl7UqzT6uHT17zeZyKWnL5kk6FufVMb48Ppr/YIxxbTLQ8bBxm?=
 =?us-ascii?Q?9Mdch9Xzzh+5aI5ahwO3UquAGcGZEbikfZ+IUn/sOLH1lIQUTpYrZSamGpSI?=
 =?us-ascii?Q?4hWOLGrqdJQrFgzwBJ09rOfqHe1cXK7mKlqNp2Ju7pjpEaWNvG+5QtOky5mf?=
 =?us-ascii?Q?SSaxAahpwhb98I8+yk1kjlwbQvxef5ELTaOJkTQW6aFi3u/0kuE6FLrbtWw5?=
 =?us-ascii?Q?TGMS1IsvmkUbvAdakNb2+9H4c8KjA2ZaFY1nKvHRv+miPw3PWqA8pu3mv2AR?=
 =?us-ascii?Q?H54/4ckQXG8Tf+oJayZbB4eo7UpR0hR5n4KUza14IRvqDtFrzyWhV4N8H+8B?=
 =?us-ascii?Q?IKistMRQRDVT8bqrrZu1rVGd3H5QOxSQanmRq0qJ+Opr8VXFDl/rS7dJlMWY?=
 =?us-ascii?Q?/qRv9dwjswBstBK3/dGGJW7OqsjWF7cozKXB5ulgLtor1bzjAC/iqpby9s6w?=
 =?us-ascii?Q?b2AhPuaDRDGCUT/Y5b4cksh+WIdlunHFeOKGOUMhCXgDqJhQ78sKWt1qVbku?=
 =?us-ascii?Q?wzWx7VHH6V7qC2/xKLC8M1TCyckVlrOp0/8hn+g5UcCLSx/kLNyNBDWZ1fC9?=
 =?us-ascii?Q?MDpEwa/hY0PYSfOG82RcuK8BXNL9kL0N9IxM+jQfahTcwIVE57YHUQv9d8cS?=
 =?us-ascii?Q?709z3Qt6esWNyuO1DPt5X/Isvl5aoGwHG2ixclpKCipeFuocM0O8T71h/Naf?=
 =?us-ascii?Q?3AXvQ0G7w=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9Jybu7w0QgGIYKq5vLF6+7jLxdYU5UqSS2zxu1nVlGaws+pqxir+mcsilBN6B/t4oW+msqYONq6FRWCUCidYaBm5kqo0tPjAkedhG61qELzzG/OmzCm8xYDKy9kXSvj1ksddc1blXTFjXpeV7KO3RryMWhqdBF5ZI9urlbu0K5DOcCctm8jRzg9QboddAqNzV4aZb7wC3BbvtcnKQCVz/FnV89JBiyMlzgzRVGwNPrx4gQfqgupM2JHUGsZrzfMAozLagfxFo/td7gID3t4UrgdH98xLNIab7spTQVLDB8nDDi5ZUTHgN6vSBWfJfvJ0y1shCIT3qvbLsE3cjoCKnspHPYnrQBx62AqAO0LsI0s=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:Ik/yMsUcFrdzEhBy5kY7XRgHQz2FWS08232jG1dER0sO9T7xM4I6Cu9AqxuLMYGMO6+i7n/gv5k7af6FoAk/UCp1IvaNJQSiSMfH4HbBX1nUsjtOuN2XUjOn6qBlfRcqfRHUeY8gGa3oW3XhKLn9An03sKHFTeMvCoa1QHQPea0jN7l99bFif5ruvE8nxn7nLkWyrnaoctZXkBbh1eUrgJUbpf9JomYKjfCOHMLRUd/LlduuDdIclXgq0UM32EpTaU+OgB+0j44h26eEaoi+xIdqCMqkhAhAn8r20HYGKujTTSbjU5UM62H7H45j2Y318ZQ3fH6j/vwWNqw7XoZ5ZZBaDeOPMKubJPo2TGA5LxNNZPpHvOVdQkTKi/NhWydfXbh7J10NEQRuXkEzXwApvO/KDjyWbplVw/PUdekbdoBEACKwTe2nNn2JGLqZKNITnJy7GI/uLq/4ozHXwzLr/w==;5:uwj/VM8l4dkqoSli1xLBhS0NT0MthS4V2AVjlTzGFcC1iW9L5VMytiA/yTibNJ8hcL2swC2K8HzhqLl4Id0Rs4YLm9lDxQe+KjdJEkuk7nxpkyujYidOBO+nZaNcBXwkuyQIRftlM4fmdyeyEQVC79Itke68XBwmFmuOrZX+VXY=;24:pSRZYv9K5vk9lad+K2pHAeR3HJejywWkfTHNLHN469ontyqHIXdtvZQh0ZEISgJh0WWOkLACB+N8br4ruGtKrNbX2FRXFD2m8ikoJEPcutE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:zmV1KJoO0ijUc37zIn/ptouLg13cQhGfAFTwKp8wFz3jVDplVaf4srscARTt8ylCbRm62cV0Zeo/iqLy5uDcr3WutMt8nRkYjeKfgLpJLYiU9Q0cG3K6OCyn0ybzM9SP2PAjX++KyNUS9SkPTbIlmonQDe2TRSSDHsxtoAZhWm8uv3QJDeU2G+svo5FCnNJXGwZiI+7RamMROdLxiYiwvmNFrpBLBV3BhkUMwFQnZTDgJ6FSbbOg1mZKIvyuRMIQ;20:3XJYDhnZICgWmh/xDYMupGjkF5p08KRy6++kEMz6yamnCI0hbpw5HEvlmraFARtAp87lz0lU77pwsWmcBPpFrN4ovfDPu1opFhoAlmR+hp9mW7tWGaqDJGskOKYhoR6exs9b+ASDgHMqjKagAlrkvNIU+790J6nWMkxXXWs+iTw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 07:27:56.5496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c948e69-859b-4ac0-60f7-08d5db36572c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On Mon, Jun 25, 2018 at 11:13:20PM -0700, Andrei Vagin wrote:
> On Mon, Jun 18, 2018 at 08:34:50PM -0700, Andrei Vagin wrote:
> > Hi David,
> > 
> > We run CRIU tests for vfs/for-next, and today a few of these test failed. I
> > found that the problem appears after this patch..
> > 
> > >  int pid_ns_prepare_proc(struct pid_namespace *ns)
> > >  {
> > > +	struct proc_fs_context *ctx;
> > > +	struct fs_context *fc;
> > >  	struct vfsmount *mnt;
> > > +	int ret;
> > > +
> > > +	fc = vfs_new_fs_context(&proc_fs_type, NULL, 0,
> > > +				FS_CONTEXT_FOR_KERNEL_MOUNT);
> > > +	if (IS_ERR(fc))
> > > +		return PTR_ERR(fc);
> > > +
> > > +	ctx = container_of(fc, struct proc_fs_context, fc);
> > > +	if (ctx->pid_ns != ns) {
> > > +		put_pid_ns(ctx->pid_ns);
> > > +		get_pid_ns(ns);
> > > +		ctx->pid_ns = ns;
> > > +	}
> > > +
> > > +	ret = vfs_get_tree(fc);
> > > +	if (ret < 0) {
> > > +		put_fs_context(fc);
> > > +		return ret;
> > > +	}
> > >  
> > > -	mnt = kern_mount_data(&proc_fs_type, ns, 0);
> 
> Here ns->user_ns and get_current_cred()->user_ns are not always equal

What do you think about the attached patch?

> 
> > > +	mnt = vfs_create_mount(fc);
> > > +	put_fs_context(fc);
> > >  	if (IS_ERR(mnt))
> > >  		return PTR_ERR(mnt);
> > >  
> 
> > #define _GNU_SOURCE
> > #include <sys/types.h>
> > #include <sched.h>
> > #include <unistd.h>
> > #include <stdio.h>
> > #include <sys/mount.h>
> > #include <sys/wait.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <stdlib.h>
> > #include <grp.h>
> > #include <linux/limits.h>
> > 
> > 
> > #define NS_STACK_SIZE	4096
> > 
> > #define __stack_aligned__	__attribute__((aligned(16)))
> > 
> > /* All arguments should be above stack, because it grows down */
> > struct ns_exec_args {
> > 	char stack[NS_STACK_SIZE] __stack_aligned__;
> > 	char stack_ptr[0];
> > 	int pfd[2];
> > };
> > 
> > static int ns_exec(void *_arg)
> > {
> > 	struct ns_exec_args *args = (struct ns_exec_args *) _arg;
> > 	int ret;
> > 
> > 	close(args->pfd[1]);
> > 	if (read(args->pfd[0], &ret, sizeof(ret)) != sizeof(ret))
> > 		return -1;
> > 
> > 	setsid();
> > 
> > 	if (setuid(0) || setgid(0) || setgroups(0, NULL)) {
> > 		fprintf(stderr, "set*id failed: %m\n");
> > 		return -1;
> > 	}
> > 
> > 	if (mount("proc", "/mnt", "proc", MS_MGC_VAL | MS_NOSUID | MS_NOEXEC | MS_NODEV, NULL)) {
> > 		fprintf(stderr, "mount(/proc) failed: %m\n");
> > 		return -1;
> > 	}
> > 
> > 	return 0;
> > }
> > 
> > #define UID_MAP "0 100000 100000\n100000 200000 50000"
> > #define GID_MAP "0 400000 50000\n50000 500000 100000"
> > int main()
> > {
> > 	pid_t pid;
> > 	int ret, status;
> > 	struct ns_exec_args args;
> > 	int flags;
> > 	char pname[PATH_MAX];
> > 	int fd, pfd[2];
> > 
> > 	if (pipe(pfd))
> > 		return 1;
> > 
> > 	args.pfd[0] = pfd[0];
> > 	args.pfd[1] = pfd[1];
> > 
> > 	flags = CLONE_NEWPID | CLONE_NEWNS | CLONE_NEWUTS |
> > 		CLONE_NEWNET | CLONE_NEWIPC | CLONE_NEWUSER | SIGCHLD;
> > 
> > 	pid = clone(ns_exec, args.stack_ptr, flags, &args);
> > 	if (pid < 0) {
> > 		fprintf(stderr, "clone() failed: %m\n");
> > 		exit(1);
> > 	}
> > 
> > 
> > 	snprintf(pname, sizeof(pname), "/proc/%d/uid_map", pid);
> > 	fd = open(pname, O_WRONLY);
> > 	if (fd < 0) {
> > 		fprintf(stderr, "open(%s): %m\n", pname);
> > 		exit(1);
> > 	}
> > 	if (write(fd, UID_MAP, sizeof(UID_MAP)) < 0) {
> > 		fprintf(stderr, "write(" UID_MAP "): %m\n");
> > 		exit(1);
> > 	}
> > 	close(fd);
> > 
> > 	snprintf(pname, sizeof(pname), "/proc/%d/gid_map", pid);
> > 	fd = open(pname, O_WRONLY);
> > 	if (fd < 0) {
> > 		fprintf(stderr, "open(%s): %m\n", pname);
> > 		exit(1);
> > 	}
> > 	if (write(fd, GID_MAP, sizeof(GID_MAP)) < 0) {
> > 		fprintf(stderr, "write(" GID_MAP "): %m\n");
> > 		exit(1);
> > 	}
> > 	close(fd);
> > 
> > 	if (write(pfd[1], &ret, sizeof(ret)) != sizeof(ret))
> > 		return 1;
> > 
> > 	if (waitpid(pid, &status, 0) != pid)
> > 		return 1;
> > 	if (status)
> > 		return 1;
> > 
> > 	return 0;
> > }
> 

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=p

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 97e8c1dc4e3b..ad2db7504031 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -235,10 +235,11 @@ EXPORT_SYMBOL(generic_parse_monolithic);
  * another superblock (referred to by @reference) is supplied, may have
  * parameters such as namespaces copied across from that superblock.
  */
-struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
+struct fs_context *vfs_new_fs_context_userns(struct file_system_type *fs_type,
 				      struct dentry *reference,
 				      unsigned int sb_flags,
-				      enum fs_context_purpose purpose)
+				      enum fs_context_purpose purpose,
+				      struct user_namespace *user_ns)
 {
 	struct fs_context *fc;
 	int ret;
@@ -259,7 +260,7 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
 		fc->sb_flags |= SB_KERNMOUNT;
 		/* Fallthrough */
 	case FS_CONTEXT_FOR_USER_MOUNT:
-		fc->user_ns = get_user_ns(fc->cred->user_ns);
+		fc->user_ns = get_user_ns(user_ns ? : fc->cred->user_ns);
 		fc->net_ns = get_net(current->nsproxy->net_ns);
 		break;
 	case FS_CONTEXT_FOR_SUBMOUNT:
diff --git a/fs/proc/root.c b/fs/proc/root.c
index efbdc08a3c86..c832d67067d9 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -298,8 +298,8 @@ int pid_ns_prepare_proc(struct pid_namespace *ns)
 	struct vfsmount *mnt;
 	int ret;
 
-	fc = vfs_new_fs_context(&proc_fs_type, NULL, 0,
-				FS_CONTEXT_FOR_KERNEL_MOUNT);
+	fc = vfs_new_fs_context_userns(&proc_fs_type, NULL, 0,
+				FS_CONTEXT_FOR_KERNEL_MOUNT, ns->user_ns);
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 04ea338ff490..283212cda1ff 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -92,10 +92,19 @@ struct fs_context_operations {
 /*
  * fs_context manipulation functions.
  */
-extern struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
+extern struct fs_context *vfs_new_fs_context_userns(struct file_system_type *fs_type,
 					     struct dentry *reference,
 					     unsigned int ms_flags,
-					     enum fs_context_purpose purpose);
+					     enum fs_context_purpose purpose,
+					     struct user_namespace *user_ns);
+static inline struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
+					     struct dentry *reference,
+					     unsigned int ms_flags,
+					     enum fs_context_purpose purpose)
+{
+	return vfs_new_fs_context_userns(fs_type, reference, ms_flags, purpose, NULL);
+}
+
 extern struct fs_context *vfs_sb_reconfig(struct path *path, unsigned int ms_flags);
 extern struct fs_context *vfs_dup_fs_context(struct fs_context *src);
 extern int vfs_set_fs_source(struct fs_context *fc, const char *source, size_t len);

--UlVJffcvxoiEqYs2--
