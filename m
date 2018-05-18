Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZo0TC4d5Qki4Iih4LYb1+gfF1jyZU2N+5IRKO2O+TcmtZ3oUCECBv8V/8VxODbI64K+MruG
ARC-Seal: i=1; a=rsa-sha256; t=1526614655; cv=none;
        d=google.com; s=arc-20160816;
        b=e+dUmT4eXHL/XJ1LQWHxzBco3wx4aMy6AYdEwnQEWNgVV/dHSB0h1ebkyip4pHGV5j
         Tsh+ZHNPhVy5xzY3ydQI+WHUDsajd1mp2e9G/6Z6GyKYxVN9G824KLzpg550asvMvvda
         wpBp5vyTmrucjQ9CU1bGdiN+lPShyYv/An4yL4cSmqxNJq76q0SCw0Md0oeLcShJrAV3
         j3Y+yppjyx2FPzv2fpsAlvW6rwkHhNwLLr8PO6VoZMk8syKdf69oRaWfWVan2/BIxcIi
         RdqLO2dYql8jBoeqepYME/CF2i/2Q2gfaF7Ibo6e7CwJGVUBG2rv1UOtA7qlB5THwEyU
         lE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=9nqH7RTif9Tb8wQ1Z1eDbP42Cooa1+0NGFQs5nNJUDA=;
        b=p4jtbSVHhBbEl0infUE0uaRNOgWx1ddBuRV6s8ajuHF0uwSIEW+z3xP2JmYt+EQny3
         UlMKIzVC9j+rjHb1ZyAd342sW033L5IoDZjLVFQ0ullgM8DDwuUiJ0abtBLX+tRRSUQ9
         rCQRY6w/2euDa4eAL/v26wvFlMwIfqhEg1Wx8NOZ1wpgmdqMDNbxfJXwKApIhQQb7Wec
         1GFzT9RjIeQoWzkje/mzuuUBWq1/W2FRCr89xQ/VWqWhJ7Hs+ZHnLZEaTtda2ZumQSre
         R2eJ6U/K384R79xk9Un6Ks3+ldIIPx6blk9KWPNrPUFB88HBRmzRJhz+b0Dr0EUYpBFc
         Dv9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,  linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org,  David Howells <dhowells@redhat.com>,  "Luis R . Rodriguez" <mcgrof@kernel.org>,  kexec@lists.infradead.org,  Andres Rodriguez <andresx7@gmail.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Ard Biesheuvel <ard.biesheuvel@linaro.org>,  Kees Cook <keescook@chromium.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
	<74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
Date: Thu, 17 May 2018 22:37:23 -0500
In-Reply-To: <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com> (Casey
	Schaufler's message of "Thu, 17 May 2018 17:24:36 -0700")
Message-ID: <87y3ghhbws.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fJWCu-00015t-Sx;;;mid=<87y3ghhbws.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18PowzMLgO4QJviA6fk2tNgB80cxd0ZtgI=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.7 XMSubLong Long Subject
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.1 XMSolicitRefs_0 Weightloss drug
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Casey Schaufler <casey@schaufler-ca.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 263 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 8 (3.2%), b_tie_ro: 6 (2.3%), parse: 1.00 (0.4%),
	extract_message_metadata: 17 (6.3%), get_uri_detail_list: 1.97 (0.7%),
	tests_pri_-1000: 7 (2.6%), tests_pri_-950: 1.23 (0.5%), tests_pri_-900: 1.01
	(0.4%), tests_pri_-400: 21 (8.1%), check_bayes: 20 (7.7%), b_tokenize: 7
	(2.6%), b_tok_get_all: 7 (2.5%), b_comp_prob: 2.0 (0.8%), b_tok_touch_all:
	2.6 (1.0%), b_finish: 0.57 (0.2%), tests_pri_0: 198 (75.2%),
	check_dkim_signature: 0.46 (0.2%), check_dkim_adsp: 2.6 (1.0%),
	tests_pri_500: 6 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob() wrapper
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723179870285580?=
X-GMAIL-MSGID: =?utf-8?q?1600771489001858283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 5/17/2018 7:48 AM, Mimi Zohar wrote:
>> In order for LSMs and IMA-appraisal to differentiate between the original
>> and new syscalls (eg. kexec, kernel modules, firmware), both the original
>> and new syscalls must call an LSM hook.
>>
>> Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
>> introduced calling security_kernel_module_from_file() in both the original
>> and new syscalls.  Commit a1db74209483 ("module: replace
>> copy_module_from_fd with kernel version") replaced these LSM calls with
>> security_kernel_read_file().
>>
>> Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
>> with kernel version") and commit b804defe4297  ("kexec: replace call to
>> copy_file_from_fd() with kernel version") replaced their own version of
>> reading a file from the kernel with the generic
>> kernel_read_file_from_path/fd() versions, which call the pre and post
>> security_kernel_read_file LSM hooks.
>>
>> Missing are LSM calls in the original kexec syscall and firmware sysfs
>> fallback method.  From a technical perspective there is no justification
>> for defining a new LSM hook, as the existing security_kernel_read_file()
>> works just fine.  The original syscalls, however, do not read a file, so
>> the security hook name is inappropriate.  Instead of defining a new LSM
>> hook, this patch defines security_kernel_read_blob() as a wrapper for
>> the existing LSM security_kernel_file_read() hook.
>
> What a marvelous opportunity to bikeshed!
>
> I really dislike adding another security_ interface just because
> the name isn't quite right. Especially a wrapper, which is just
> code and execution overhead. Why not change security_kernel_read_file()
> to security_kernel_read_blob() everywhere and be done?

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Nack on this sharing nonsense.  These two interfaces do not share any
code in their implementations other than the if statement to distinguish
between the two cases.

Casey you are wrong.  We need something different here.

Mimi a wrapper does not cut it.   The code is not shared.  Despite using
a single function call today.

If we want comprehensible and maintainable code in the security modules
we need to split these two pieces of functionality apart.

Eric
