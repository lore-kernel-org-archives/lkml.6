Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB81C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3000E20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SqPO+eek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfAVFbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:31:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49698 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAVFbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:31:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0M5TcUL071744;
        Tue, 22 Jan 2019 05:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=zkypv4rsjB8wJOxKtveDAmZ0JRpQxLGrXLwjO6YIE8Y=;
 b=SqPO+eekQo0KTK3LmW9eT6PAOET/DP368lAiCvPNpK+g98qqVF5wJfUxrnjTnKVeAzE5
 wHsMMmQ3oGdKyLoRY0/49LdHdr+RiwddpS+6f/TWgQm3LUOxrOzcyoqDROuFZwq+pJ4V
 YxQ/Fx6P760MLOAzHJ4B8tR9+qSkQU+euTWbIsECVs8KpejYzTfBlFJXMBsmYZ08OZM9
 6p2th4GY2o5A52maXty3ELrirD8vZsYqnQZsZd5caGoPl3OUu3NSm9SEM/EHGiYOrogR
 PvtZO1dfSVRaz+aBhv9Ee2I1Q+eb5+jt6gNLtE2gtRkDpaYlFdNEOuWrFEx52R8I1/Fg NA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q3sde9m88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 05:31:10 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0M5VA5l012077
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 05:31:10 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0M5V9EJ022811;
        Tue, 22 Jan 2019 05:31:10 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jan 2019 21:31:09 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id A9D136A0129; Tue, 22 Jan 2019 00:31:08 -0500 (EST)
Date:   Tue, 22 Jan 2019 00:31:08 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Lei Chen <chenl.lei@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     tglx@linutronix.de
Subject: Re: /proc/<pid>/status: incorrect format breaks userland tool
Message-ID: <20190122053108.GA14185@char.us.oracle.com>
References: <CAB5AJuWz2NgwixCDh3hr4uv8qECfE2m0q49E_5GfecTnGPuXuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <CAB5AJuWz2NgwixCDh3hr4uv8qECfE2m0q49E_5GfecTnGPuXuQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9143 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901220045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 11:29:16AM +0800, Lei Chen wrote:
> Hi Konrad,

Hi,

CC-ing stable,Greg,and LKML. Pls see attached and inline patch and explanation
at bottom.

> I'm running kernel 4.4.153. When running iotop, I got such failure:
>  # iotop -P
> Traceback (most recent call last):
>   File "/sbin/iotop", line 17, in <module>
>     main()
>   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 620, in main
>     main_loop()
>   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 610, in <lambda>
>     main_loop = lambda: run_iotop(options)
>   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 508, in
> run_iotop
>     return curses.wrapper(run_iotop_window, options)
>   File "/usr/lib/python2.7/curses/wrapper.py", line 43, in wrapper
>     return func(stdscr, *args, **kwds)
>   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 501, in
> run_iotop_window
>     ui.run()
>   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 155, in run
>     self.process_list.duration)
>   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 434, in
> refresh_display
>     lines = self.get_data()
>   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 415, in get_data
>     return list(map(format, processes))
>   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 388, in format
>     cmdline = p.get_cmdline()
>   File "/usr/lib/python2.7/site-packages/iotop/data.py", line 292, in
> get_cmdline
>     proc_status = parse_proc_pid_status(self.pid)
>   File "/usr/lib/python2.7/site-packages/iotop/data.py", line 196, in
> parse_proc_pid_status
>     key, value = line.split(':\t', 1)
> ValueError: need more than 1 value to unpack
> 
> Having a little further debug, I found this error is caused by the
> unexpected blank line in /proc/<pid>/status file, like below:
> 
> CapBnd: 0000003fffffffff
> CapAmb: 0000000000000000
> 
> Speculation_Store_Bypass:       vulnerable
> Cpus_allowed:   ff
> 
> Checking the git history, I see you touched the line "seq_printf(m,
> "\nSpeculation_Store_Bypass:\t");". Do you think this additional blank line
> is caused by the leading "\n" of "Speculation_Store_Bypass"?

That is correct.
It looks that the backport missed the change. The v4.4 has:

static inline void task_seccomp(struct seq_file *m, struct task_struct *p)         
{                                                                                  
#ifdef CONFIG_SECCOMP                                                              
        seq_printf(m, "Seccomp:\t%d\n", p->seccomp.mode);                          
#endif                                                                             
        seq_printf(m, "\nSpeculation_Store_Bypass:\t");      

Upstream has:

tatic inline void task_seccomp(struct seq_file *m, struct task_struct *p)         
{                                                                                  
        seq_put_decimal_ull(m, "NoNewPrivs:\t", task_no_new_privs(p));             
#ifdef CONFIG_SECCOMP                                                              
        seq_put_decimal_ull(m, "\nSeccomp:\t", p->seccomp.mode);                   
#endif                                                                             
        seq_printf(m, "\nSpeculation_Store_Bypass:\t");                         

The af884cd4a5ae6 is the one that removed the '\n' from the end and put it in the
front of 'Seccomp '.

Greg, I am not sure how one would fix this in a stable tree. But the fix is simple
(hadn't tested it..)

From 9e1909f29e1162f2fba190dbab88d1bbcaf0365d Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Tue, 22 Jan 2019 00:27:55 -0500
Subject: [PATCH] Fix: proc: Use underscores for SSBD in 'status'

Upstream af884cd4a5ae6 (not backported) added a '\n' in front
of 'Seccomp' but we have the old format with '\n' at the end.
This causes mayhem with 'Speculation_Store_Bypass' adding an extra
newline breaking tools.

Reported-by:Lei Chen <chenl.lei@gmail.com>
CC: stable@vger.kernel.org
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index cb71cbae606d..60cbaa821164 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -333,7 +333,7 @@ static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
 #ifdef CONFIG_SECCOMP
 	seq_printf(m, "Seccomp:\t%d\n", p->seccomp.mode);
 #endif
-	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
+	seq_printf(m, "Speculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
 	case -EINVAL:
 		seq_printf(m, "unknown");
-- 
2.13.4


> 
> Thanks,
> Lei Chen

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Fix-proc-Use-underscores-for-SSBD-in-status.patch"

From 9e1909f29e1162f2fba190dbab88d1bbcaf0365d Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Tue, 22 Jan 2019 00:27:55 -0500
Subject: [PATCH] Fix: proc: Use underscores for SSBD in 'status'

Upstream af884cd4a5ae6 (not backported) added a '\n' in front
of 'Seccomp' but we have the old format with '\n' at the end.
This causes mayhem with 'Speculation_Store_Bypass' adding an extra
newline breaking tools.

Reported-by:Lei Chen <chenl.lei@gmail.com>
CC: stable@vger.kernel.org
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index cb71cbae606d..60cbaa821164 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -333,7 +333,7 @@ static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
 #ifdef CONFIG_SECCOMP
 	seq_printf(m, "Seccomp:\t%d\n", p->seccomp.mode);
 #endif
-	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
+	seq_printf(m, "Speculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
 	case -EINVAL:
 		seq_printf(m, "unknown");
-- 
2.13.4


--J2SCkAp4GZ/dPZZf--
