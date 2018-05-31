Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755986AbeEaRxE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:53:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41665 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755960AbeEaRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:52:57 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
        <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
        <87h8oqhagl.fsf@xmission.com>
        <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
        <e1402871-77a5-6a0f-a75c-ccad77b93f49@oracle.com>
        <778ab3d0-b6bc-fdb5-669a-40222e5020d4@yandex-team.ru>
        <e3a1076d-cfd7-a034-dd08-2d74fbf751f3@oracle.com>
        <3e2c285a-1bf8-f71d-1b74-4d6465c29a54@yandex-team.ru>
        <3bdd6b27-0a46-5802-8671-07268cecc1c7@oracle.com>
Date: Thu, 31 May 2018 12:52:49 -0500
In-Reply-To: <3bdd6b27-0a46-5802-8671-07268cecc1c7@oracle.com> (Nagarathnam
        Muthusamy's message of "Thu, 31 May 2018 10:41:20 -0700")
Message-ID: <87efhremq6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fORks-0007ta-IY;;;mid=<87efhremq6.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/D508xSPKGvYRw+Qq6+gQs8EY0qnLs6hk=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 450 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.4 (0.8%), b_tie_ro: 2.3 (0.5%), parse: 1.67 (0.4%),
        extract_message_metadata: 30 (6.7%), get_uri_detail_list: 8 (1.7%),
        tests_pri_-1000: 13 (2.9%), tests_pri_-950: 1.62 (0.4%), tests_pri_-900: 1.27
        (0.3%), tests_pri_-400: 38 (8.5%), check_bayes: 37 (8.2%), b_tokenize: 15
        (3.4%), b_tok_get_all: 12 (2.6%), b_comp_prob: 4.0 (0.9%), b_tok_touch_all:
        3.4 (0.8%), b_finish: 0.69 (0.2%), tests_pri_0: 352 (78.2%),
        check_dkim_signature: 0.65 (0.1%), check_dkim_adsp: 3.7 (0.8%),
        tests_pri_500: 3.8 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:

> On 05/15/2018 10:36 AM, Konstantin Khlebnikov wrote:
>>
>>
>> On 15.05.2018 20:19, Nagarathnam Muthusamy wrote:
>>>
>>>
>>> On 04/24/2018 10:36 PM, Konstantin Khlebnikov wrote:
>>>> On 23.04.2018 20:37, Nagarathnam Muthusamy wrote:
>>>>>
>>>>>
>>>>> On 04/05/2018 12:02 AM, Konstantin Khlebnikov wrote:
>>>>>> On 05.04.2018 01:29, Eric W. Biederman wrote:
>>>>>>> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>>>>>>>
>>>>>>>> On 04/04/2018 12:11 PM, Konstantin Khlebnikov wrote:
>>>>>>>>> Each process have different pids, one for each pid namespace
>>>>>>>>> it belongs.
>>>>>>>>> When interaction happens within single pid-ns translation
>>>>>>>>> isn't required.
>>>>>>>>> More complicated scenarios needs special handling.
>>>>>>>>>
>>>>>>>>> For example:
>>>>>>>>> - reading pid-files or logs written inside container with pid
>>>>>>>>> namespace
>>>>>>>>> - attaching with ptrace to tasks from different pid namespace
>>>>>>>>> - passing pids across pid namespaces in any kind of API
>>>>>>>>>
>>>>>>>>> Currently there are several interfaces that could be used here:
>>>>>>>>>
>>>>>>>>> Pid namespaces are identified by inode number of
>>>>>>>>> /proc/[pid]/ns/pid.
>>>>>>>
>>>>>>> Using the inode number in interfaces is not an
>>>>>>> option. Especially not
>>>>>>> withou referencing the device number for the filesystem as well.
>>>>>>
>>>>>> This is supposed to be single-instance fs,
>>>>>> not part of proc but referenced but its magic "symlinks".
>>>>>>
>>>>>> Device numbers are not mentioned in "man namespaces".
>>>>>>
>>>>>>>
>>>>>>>>> Pids for nested Pid namespaces are shown in file
>>>>>>>>> /proc/[pid]/status.
>>>>>>>>> In some cases conversion pid -> vpid could be easily done
>>>>>>>>> using this
>>>>>>>>> information, but backward translation requires scanning all tasks.
>>>>>>>>>
>>>>>>>>> Unix socket automatically translates pid attached to
>>>>>>>>> SCM_CREDENTIALS.
>>>>>>>>> This requires CAP_SYS_ADMIN for sending arbitrary pids and
>>>>>>>>> entering
>>>>>>>>> into pid namespace, this expose process and could be insecure.
>>>>>>>>>
>>>>>>>>> This patch adds new syscall for converting pids between pid
>>>>>>>>> namespaces:
>>>>>>>>>
>>>>>>>>> pid_t translate_pid(pid_t pid, int source_type, int source,
>>>>>>>>>                                  int target_type, int target);
>>>>>>>>>
>>>>>>>>> @source_type and @target_type defines type of following arguments:
>>>>>>>>>
>>>>>>>>> TRANSLATE_PID_CURRENT_PIDNS  - current pid namespace,
>>>>>>>>> argument is unused
>>>>>>>>> TRANSLATE_PID_TASK_PIDNS     - task pid-ns, argument is task pid
>>>>>>>>
>>>>>>>> I believe using pid to represent the namespace has been already
>>>>>>>> discussed in V1 of this patch in
>>>>>>>> https://lkml.org/lkml/2015/9/22/1087
>>>>>>>> after which we moved on to fd based version of this interface.
>>>>>>>
>>>>>>> Or in short why is the case of pids important?
>>>>>>>
>>>>>>> You Konstantin you almost said why they were important in your
>>>>>>> message
>>>>>>> saying you were going to send this one.  However you don't
>>>>>>> explain in
>>>>>>> your description why you want to identify pid namespaces by pid.
>>>>>>>
>>>>>>
>>>>>> Open of /proc/[pid]/ns/pid requires same permissions as ptrace,
>>>>>> pid based variant doesn't have such restrictions.
>>>>>
>>>>> Can you provide more information on usecase requiring PID
>>>>> translation but not used for tracing related purposes?
>>>>
>>>> Any introspection for [nested] containers. It's easier to work
>>>> when you have all information when you don't have any.
>>>> For example our CMS https://github.com/yandex/porto allows to
>>>> start nested sub-container (or even deeper) by request from any
>>>> container and have to tell back which pid task is have. And it
>>>> could translate any pid inside into accessible by client and vice
>>>> versa.
>>>>
>>>
>>> I still dont get the exact reason why PID based approach to
>>> identify the namespace during pid translation process is absolutely
>>> required compared to fd based approach. 
>>
>> As I told open(/proc/%d/ns/pid) have security restrictions - same
>> uid/CAP_SYS_PTRACE/whatever
>> Pidns-fd holds pid-namespace and without restrictions could be abused.
>> Pid based API is racy but always available without any restrictions.
>>
>>
>>> From your version of TranslatePid in
>>>
>>> https://github.com/yandex/porto/blob/0d7e6e7e1830dcd0038a057b2ab9964cec5b8fab/src/util/unix.cpp 
>>>
>>>
>>> I see that you are going through the trouble of forking a process
>>> and sending SMC_CREDENTIALS for pid translation. Even your existing
>>> API could be extremely simplified if translate_pid based on file
>>> descriptors make it to the gate and I believe from the last
>>> discussion it was almost there
>>> https://patchwork.kernel.org/patch/10305439/
>>>
>>>
>>>>> On a side note, can we have the types TRANSLATE_PID_CURRENT_PIDNS
>>>>> and TRANSLATE_PID_FD_PIDNS integrated first and then possibly
>>>>> extend the interface to include TRANSLATE_PID_TASK_PIDNS in
>>>>> future?
>>>>
>>>> I don't see reason for this separation.
>>>> Pids and pid namespaces are part of the API for a long time.
>>>
>>> If you are talking about the translate_pid API proposed, I believe
>>> the V4 proposed under https://patchwork.kernel.org/patch/10003935/
>>> had only fd based API before a mix of PID and fd based is proposed
>>> in V5. Again, I was just wondering if we can get the FD based
>>> approach in first and then extend the API to include PID based
>>> approach later as fd based approach could provide a lot of
>>> immediate benefits?
>>>
>>> Thanks,
>>> Nagarathnam.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Nagarathnam.
>>>>>> Most pid-based syscalls are racy in some cases but they are
>>>>>> here for decades and everybody knowns how to deal with it.
>>>>>> So, I've decided to merge both worlds in one interface which
>>>>>> clearly tells what to expect.
>>>>>
>>>
>
> Ping? Any additional comments on this patch?

I have totally lost the thread.  Let me see if I can find enough of the
thread to see what is going on.

The whole let's use pids instead of fds was a major distraction.

Eric
