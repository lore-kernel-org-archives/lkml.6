Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336C0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E688F2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E688F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeKHFKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:10:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbeKHFKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:10:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7JXosG013852
        for <linux-kernel@vger.kernel.org>; Wed, 7 Nov 2018 14:38:52 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nm57g2w01-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 14:38:52 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 7 Nov 2018 19:38:51 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Nov 2018 19:38:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA7JciC319988698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 19:38:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E22DB2065;
        Wed,  7 Nov 2018 19:38:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43B3EB2067;
        Wed,  7 Nov 2018 19:38:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.190.52])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Nov 2018 19:38:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1AD9F16C41EE; Wed,  7 Nov 2018 11:38:44 -0800 (PST)
Date:   Wed, 7 Nov 2018 11:38:44 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Reply-To: paulmck@linux.ibm.com
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107171149.165693799@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110719-2213-0000-0000-0000031317BF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010003; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01114102; UDB=6.00577581; IPR=6.00894201;
 MB=3.00024064; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-07 19:38:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110719-2214-0000-0000-00005C2CC033
Message-Id: <20181107193844.GY4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 06:10:12PM +0100, Thomas Gleixner wrote:
> Add a document to the subsystem/maintainer handbook section, which explains
> what the tip tree is, how it operates and what rules and expectations it
> has.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

A few more suggestions below, again to new text.  I have, admittedly
uncharacteristically, trimmed the patch.  ;-)

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  Documentation/process/maintainer-handbooks.rst |    2 
>  Documentation/process/maintainer-tip.rst       |  796 +++++++++++++++++++++++++
>  2 files changed, 798 insertions(+)
> 
> --- a/Documentation/process/maintainer-handbooks.rst
> +++ b/Documentation/process/maintainer-handbooks.rst
> @@ -12,3 +12,5 @@ which is supplementary to the general de
>  .. toctree::
>     :numbered:
>     :maxdepth: 2
> +
> +   maintainer-tip
> --- /dev/null
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -0,0 +1,796 @@
> +The tip tree handbook
> +=====================
> +
> +What is the tip tree?
> +---------------------
> +
> +The tip tree is a collection of several subsystems and areas of
> +development. The tip tree is both a direct development tree and a
> +aggregation tree for several sub-maintainer trees. The tip tree gitweb URL
> +is: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> +
> +The tip tree contains the following subsystems:
> +
> +   - **x86 architecture**
> +
> +     The x86 architecture development takes place in the tip tree except
> +     for the x86 KVM and XEN specific parts which are maintained in the
> +     corresponding subsystems and routed directly to mainline from
> +     there. It's still good practice to Cc the x86 maintainers on
> +     x86-specific KVM and XEN patches.
> +
> +     Some x86 subsystems have their own maintainers in addition to the
> +     overall x86 maintainers.  Please Cc the overall x86 maintainers on
> +     patches touching files in arch/x86 even when they are not called out
> +     by the MAINTAINER file.
> +
> +     Note, that ``x86@kernel.org`` is not a mailing list. It is merely a
> +     mail alias which distributes mails to the x86 top-level maintainer
> +     team. Please always Cc the Linux Kernel mailing list (LKML)
> +     ``linux-kernel@vger.kernel.org``, otherwise your mail ends up only in
> +     the private inboxes of the maintainers.
> +
> +   - **Scheduler**
> +
> +   - **Locking and atomics**
> +
> +   - **Generic interrupt subsystem and interrupt chip drivers**:
> +
> +     - interrupt core development happens in the irq/core branch
> +
> +     - interrupt chip driver development happens also in the irq/core
> +       branch, but the patches are mostly applied in a separate maintainer

        - interrupt chip driver development also happens in the irq/core
          branch, but the patches are usually applied in a separate maintainer

> +       tree and then aggregated into irq/core
> +
> +   - **Time, timers, timekeeping, NOHZ and related chip drivers**:
> +
> +     - timekeeping, clocksource core, NTP and alarmtimer development
> +       happens in the timers/core branch, but patches are mostly applied in

          happens in the timers/core branch, but patches are usually applied in

> +       a separate maintainer tree and then aggregated into timers/core
> +
> +     - clocksource/event driver development happens in the timers/core
> +       branch, but patches are mostly applied in a separate maintainer tree
> +       and then aggregated into timers/core
> +
> +   - **Performance counters core, architecture support and tooling**:
> +
> +     - perf core and architecture support development happens in the
> +       perf/core branch
> +
> +     - perf tooling development happens in the perf tools maintainer
> +       tree and is aggregated into the tip tree.
> +
> +   - **CPU hotplug core**
> +
> +   - **RAS core**
> +
> +   - **EFI core**
> +
> +     EFI development in the efi git tree. The collected patches are
> +     aggregated in the tip efi/core branch.
> +
> +   - **RCU**
> +
> +     RCU development happens in the linux-rcu tree. The resulting changes
> +     are aggregated into the tip core/rcu branch.
> +
> +   - **Various core code components**:
> +
> +       - debugobjects
> +
> +       - objtool
> +
> +       - random bits and pieces

[ . . . ]

> +Backtraces in changelogs
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Backtraces can be useful to document the call chain which led to a
> +problem. Though not all back traces are really valuable because the call
> +chain is unique and obvious, e.g. in early boot code. Just copying the full
> +dmesg output is adding a lot of distracting information like timestamps,
> +module lists, register and stack dumps etc.

   Backtraces help document the call chain leading to a problem. However,
   not all back traces are helpful, for example. early boot call chains
   are unique and obvious. Furthermore, copying the full dmesg output
   adds distracting information like timestamps, module lists, register
   and stack dumps.

> +Reducing the backtrace to the real relevant data helps to concentrate on
> +the issue and not being distracted by destilling the relevant information
> +out of the dump. Here is an example of a well trimmed backtrace::

   In constrast, the most useful backtraces distill the relevant
   information from the dump, which makes it easier to focus on the
   real issue.  Here is an example of a well-trimmed backtrace::

> +  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000
> +  000000000064) at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
> +  Call Trace:
> +  mba_wrmsr+0x41/0x80
> +  update_domains+0x125/0x130
> +  rdtgroup_mkdir+0x270/0x500

[ . . . ]

> +Namespaces
> +^^^^^^^^^^
> +
> +To improve readability and to allow easy grepping for information the usage
> +of consistent namespaces is important. The namespace should be used as a
> +prefix for globally visible (inline) functions and variables. A simple rule
> +for chosing a namespace prefix is to combine the subsystem and the
> +component name, e.g. 'x86_comp\_', 'sched\_', 'irq\_', 'mutex\_', etc. For
> +static functions and variables the namespace prefix can be omitted.

   Function/variable namespaces improve readability and allow easy
   grepping.  These namespaces are prefixes for globally visible function
   and variable names, including inlines.  These prefixes should combine
   the subsystem and the component name such as 'x86_comp\_', 'sched\_',
   'irq\_', and 'mutex\_'.  Namespace prefixes may be omitted for local
   static functions and variables.

> +Also be careful when using vendor names in namespaces. There is no value of
> +having 'xxx_vendor\_' or 'vendor_xxx_` as prefix for all static functions
> +of a vendor specific file as it is already clear that the code is vendor
> +specific. Aside of that vendor names should only be used when it is really
> +vendor specific functionality.

   Please note that 'xxx_vendor\_' and 'vendor_xxx_` prefixes are not
   helpful for static functions in vendor-specific files. After all,
   it is already clear that the code is vendor specific. In addition,
   vendor names should only be for truly vendor-specific functionality.

> +As always apply common sense and aim for consistency and readability.
> +
> +
> +Commit notifications
> +--------------------
> +
> +The tip tree is monitored by a bot for new commits. The bot sends an email
> +for each new commit to a dedicated mailing list
> +(``linux-tip-commits@vger.kernel.org``) and Cc's all people who are
> +mentioned in one of the commit tags. It uses the email message id from the
> +Link tag at the end of the tag list to set the In-Reply-To email header so
> +the message is properly threaded with the patch submission email.
> +
> +The maintainers try to reply to the submitter when merging a patch, but
> +they sometimes forget or it does not fit the workflow of the moment. While
> +the bot message is purely mechanical assume it implies a 'Thank you!
> +Applied.'.
> 
> 

