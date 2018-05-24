Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033896AbeEXQmf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:42:35 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45456 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033857AbeEXQmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:42:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Cong Wang <xiyou.wangcong@gmail.com>, Neil Horman <nhorman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>, dzickus@redhat.com,
        bhe@redhat.com
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
        <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
        <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
        <877enucqr0.fsf@xmission.com>
        <20180524014234.GA2031@dhcp-128-65.nay.redhat.com>
Date: Thu, 24 May 2018 11:41:58 -0500
In-Reply-To: <20180524014234.GA2031@dhcp-128-65.nay.redhat.com> (Dave Young's
        message of "Thu, 24 May 2018 09:42:34 +0800")
Message-ID: <87bmd53t0p.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLtJW-0006La-My;;;mid=<87bmd53t0p.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1836wJXmzaZVLGvrPeZ4DoLSsb/CE4KAcU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Dave Young <dyoung@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15022 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.0%), b_tie_ro: 1.90 (0.0%), parse: 1.11 (0.0%),
        extract_message_metadata: 4.0 (0.0%), get_uri_detail_list: 1.98 (0.0%),
        tests_pri_-1000: 5 (0.0%), tests_pri_-950: 1.71 (0.0%), tests_pri_-900: 1.07
        (0.0%), tests_pri_-400: 25 (0.2%), check_bayes: 24 (0.2%), b_tokenize: 9
        (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob: 2.5 (0.0%), b_tok_touch_all:
        2.6 (0.0%), b_finish: 0.59 (0.0%), tests_pri_0: 292 (1.9%),
        check_dkim_signature: 1.03 (0.0%), check_dkim_adsp: 3.7 (0.0%),
        tests_pri_500: 14680 (97.7%), poll_dns_idle: 14672 (97.7%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config options
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Young <dyoung@redhat.com> writes:

> Hi Eric,
> On 05/23/18 at 10:53am, Eric W. Biederman wrote:
>> Dave Young <dyoung@redhat.com> writes:
>> 
>> > [snip]
>> >
>> >> >  
>> >> > +config CRASHKERNEL_DEFAULT_THRESHOLD_MB
>> >> > +	int "System memory size threshold for kdump memory default reserving"
>> >> > +	depends on CRASH_CORE
>> >> > +	default 0
>> >> > +	help
>> >> > +	  CRASHKERNEL_DEFAULT_MB is used as default crashkernel value if
>> >> > +	  the system memory size is equal or bigger than the threshold.
>> >> 
>> >> "the threshold" is rather vague.  Can it be clarified?
>> >> 
>> >> In fact I'm really struggling to understand the logic here....
>> >> 
>> >> 
>> >> > +config CRASHKERNEL_DEFAULT_MB
>> >> > +	int "Default crashkernel memory size reserved for kdump"
>> >> > +	depends on CRASH_CORE
>> >> > +	default 0
>> >> > +	help
>> >> > +	  This is used as the default kdump reserved memory size in MB.
>> >> > +	  crashkernel=X kernel cmdline can overwrite this value.
>> >> > +
>> >> >  config HAVE_IMA_KEXEC
>> >> >  	bool
>> >> >  
>> >> > @@ -143,6 +144,24 @@ static int __init parse_crashkernel_simp
>> >> >  	return 0;
>> >> >  }
>> >> >  
>> >> > +static int __init get_crashkernel_default(unsigned long long system_ram,
>> >> > +					  unsigned long long *size)
>> >> > +{
>> >> > +	unsigned long long sz = CONFIG_CRASHKERNEL_DEFAULT_MB;
>> >> > +	unsigned long long thres = CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB;
>> >> > +
>> >> > +	thres *= SZ_1M;
>> >> > +	sz *= SZ_1M;
>> >> > +
>> >> > +	if (sz >= system_ram || system_ram < thres) {
>> >> > +		pr_debug("crashkernel default size can not be used.\n");
>> >> > +		return -EINVAL;
>> >> 
>> >> In other words,
>> >> 
>> >> 	if (system_ram <= CONFIG_CRASHKERNEL_DEFAULT_MB ||
>> >> 	    system_ram < CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB)
>> >> 		fail;
>> >> 
>> >> yes?
>> >> 
>> >> How come?  What's happening here?  Perhaps a (good) explanatory comment
>> >> is needed.  And clearer Kconfig text.
>> >> 
>> >> All confused :(
>> >
>> > Andrew, I tuned it a bit, removed the check of sz >= system_ram, so if
>> > the size is too large and kernel can not find enough memory it will
>> > still fail in latter code.
>> >
>> > Is below version looks clearer?
>> 
>> What is the advantage of providing this in a kconfig option rather
>> than on the kernel command line as we can now?
>
> It is not a replacement of the cmdline, this can be a supplement to
> the crashkernel command line.  For a lot of common use cases if we have
> the auto reservation user just do not need to manually set the cmdline
> for example on a virtual machine and usual setup (except of the
> comlicate storage and very large machines).  The crashkernel=auto
> has been used for long time, Red Hat QE tested it on a lot of different
> lab machines and proved it works well.  Kdump usually just works so admin
> do little work to enable kdump.
>
> But the crashkernel=auto implementation has some drawbacks that is it
> is more like embed policy in the code and it is not flexible like a
> config option.

Have you considered using the builtin command line aka CONFIG_CMDLINE?
If as you are reserving a fixed amount of memory as your patch does that
should be sufficient, and doable without any kernel changes.

Eric
