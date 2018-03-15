Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932472AbeCOUgA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:36:00 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:32986 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbeCOUf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:35:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        mkayaalp@cs.binghamton.edu,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>, sunyuqiong1988@gmail.com,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        david.safford@ge.com, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
References: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
        <20180309201421.6150-2-stefanb@linux.vnet.ibm.com>
        <87vadxfwqj.fsf@xmission.com>
        <c18b6e92-57f0-5994-eb60-5fadc6671832@linux.vnet.ibm.com>
        <1521135192.5348.64.camel@HansenPartnership.com>
        <2183a3b4-6270-d2e9-70ad-a7399eb1681c@linux.vnet.ibm.com>
        <1521139535.5348.89.camel@HansenPartnership.com>
        <0dc5b856-8dc6-7b5a-eeac-febd19f6498c@linux.vnet.ibm.com>
        <1521140467.5348.94.camel@HansenPartnership.com>
        <056e5b9e-b4d3-1862-baea-06dda4bd0713@linux.vnet.ibm.com>
        <87sh915eo0.fsf@xmission.com>
        <19ecc296-b584-4e1a-5369-30090fbc7880@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 15:35:06 -0500
In-Reply-To: <19ecc296-b584-4e1a-5369-30090fbc7880@linux.vnet.ibm.com> (Stefan
        Berger's message of "Thu, 15 Mar 2018 15:49:02 -0400")
Message-ID: <87d10513id.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ewZbP-0002ZG-E2;;;mid=<87d10513id.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/jjoN38t/7wdJ2ZJohsOIE4b/2nxh8GPk=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 312 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (1.5%), b_tie_ro: 3.2 (1.0%), parse: 1.01 (0.3%),
        extract_message_metadata: 6 (2.0%), get_uri_detail_list: 4.1 (1.3%),
        tests_pri_-1000: 3.6 (1.1%), tests_pri_-950: 1.23 (0.4%), tests_pri_-900:
        1.05 (0.3%), tests_pri_-400: 32 (10.2%), check_bayes: 31 (9.9%), b_tokenize:
        9 (2.7%), b_tok_get_all: 11 (3.6%), b_comp_prob: 2.7 (0.9%), b_tok_touch_all:
        4.0 (1.3%), b_finish: 1.14 (0.4%), tests_pri_0: 252 (80.7%),
        check_dkim_signature: 0.43 (0.1%), check_dkim_adsp: 3.7 (1.2%),
        tests_pri_500: 3.6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH v2 1/3] ima: extend clone() with IMA namespace support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> On 03/15/2018 03:20 PM, Eric W. Biederman wrote:
>> Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
>>
>>> On 03/15/2018 03:01 PM, James Bottomley wrote:
>>>> On Thu, 2018-03-15 at 14:51 -0400, Stefan Berger wrote:
>>>>> On 03/15/2018 02:45 PM, James Bottomley wrote:
>>>> [...]
>>>>>>>> going to need some type of keyring namespace and there's
>>>>>>>> already
>>>>>>>> one hanging off the user_ns:
>>>>>>>>
>>>>>>>> commit f36f8c75ae2e7d4da34f4c908cebdb4aa42c977e
>>>>>>>> Author: David Howells <dhowells@redhat.com>
>>>>>>>> Date:   Tue Sep 24 10:35:19 2013 +0100
>>>>>>>>
>>>>>>>>         KEYS: Add per-user_namespace registers for persistent
>>>>>>>> per-UID
>>>>>>>> kerberos caches
>>>>>>> The benefit for IMA would be that this would then tie the keys
>>>>>>> needed for appraising to the IMA namespace's policy.
>>>>>>> However, if you have an appraise policy in your IMA namespace,
>>>>>>> which is now hooked to the user namespace, and you join that user
>>>>>>> namespace but your files don't have signatures, nothing will
>>>>>>> execute anymore. That's now a side effect of joining this user
>>>>>>> namespace unless we have a magic  exception. My feeling is,
>>>>>>> people may not like that...
>>>>>> Agree, but I think the magic might be to populate the ima keyring
>>>>>> with the parent on user_ns creation.  That way the user_ns owner
>>>>>> can delete the parent keys if they don't like them, but by default
>>>>>> the parent appraisal policy should just work.
>>>>> That may add keys to your keyring but doesn't get you signatures on
>>>>> your  files.
>>>> But it doesn't need to.  The only way we'd get a failure is if the file
>>>> is already being appraised and we lose access to the key.  If the
>>> Well, the configuration I talked about above was assuming that we have
>>> an appraisal policy active in the IMA namespace, which is now tied to
>>> the user namespace that was just joined.
>>>
>>> If we are fine with the side effects of an IMA policy active as part
>>> of a user namespace then let's go with it. The side effects in case of
>>> an active IMA appraisal may then be that files cannot be
>>> read/accessed, or file measurements or IMA auditing may occur.
>>>
>>> The alternative is we have an independent IMA namespace. If one joins
>>> the USER namespace and there are no IMA-related side effects. If one
>>> joins the IMA namespace its IMA policy should start being enforced. If
>>> the current active USER namespace has the keys that go with the
>>> signatures of the filesystem, then we're fine from the appraisal
>>> perspective. If not, then IMA namespace joining may prevent file
>>> accesses.
>>>
>>>> parent policy isn't appraisal, entering the IMA NS won't cause
>>> Why parent policy? The policy of the namespace that was joined should
>>> be the active one, no ?
>> Unless I am completely blind we should never stop enforcing the parent's
>> polciy.  We should only add policy to enforce for the scope of a
>> container.
>
> What we want is an independent policy for each IMA namespace.
>
> What we don't want is that root can abuse his power to spawn new namespaces and
> circumvent a file appraisal policy on the host (in init_ima_ns). Because of that
> root's activities are subject to the IMA policy of the currently active IMA
> namespace and the one of init_ima_ns (and possibly all the ones in between). If
> root is working in a child IMA namespace and file appraisal fails due to the
> policy in init_ima_ns and keys found in .ima or _ima keyrings attached to
> init_user_ns, the file access will be denied.
>
> Besides that root's activities will always be measured and audited following the
> policy in init_ima_ns. This tries to prevent that root spawns an IMA namespace
> with a NULL policy and does things in the TCB and tries to escape the
> logging.

That sounds exactly like my definition of hierarchical namespace
enforcement.

And please keep in mind that everyone is allowed to use CLONE_NEWNS now.
You just have to spawn a new user namespace first so you have the caps.

>> In practice this is just the containers policy as the container is most
>> likely a do whatever you want to in the parent policy.  But not always
>> and not explicitly.
>>
>> Mount namespaces are not hierarchical, user namespaces are.  Which makes
>> them much more appropriate for being part of nested policy enforcement.
>
> We don't want additive or hierarchical policies - at least I don't. They should
> be independent. Only exception are activities of root that are always
> iteratively evaluated against policies of the current IMA NS and the init_ima_ns
> and possibly all the ones in between.

I believe that is what I meant by a nested/hiearchical policy
enforcement.

>>  From previous conversations I remember that there is a legitimate
>> bootstrap problem for IMA.  That needs to be looked at, and I am not
>> seeing that mentioned.
>
> IMA's log should not have a gap. So ideally we shouldn't have to write something
> into sysfs to spawn a new IMA namespace so that we don't miss whatever setup may
> have happened to get there, including the writing into procfs. IMA should be
> there right from the start. So a clone flag would be ideal for that.

Please make that securityfs not sysfs.  Sysfs should be about the
hardware not these higher level software details.  I really don't want
to have to namespace sysfs more than I already have.

As for the no gaps requirement.  That is a powerful lever for ruling out
solutions that don't work as well.



Eric
