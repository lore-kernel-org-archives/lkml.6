Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182748-1522881045-2-239992783119927731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522881044; b=grSNQeuI94H+f3FYWTD1NHz9BKlWFSayRiizww1UcGQRe7Np62
    pacYq+/2SLnZ5FyoZDLwOFT/ZpwnllKCGlIGG21ZeNzYmiDtW7cy/bQZVvx9IdxM
    bZL4Q6mfqB6W88s1PmkQF65SL+p1XckZV342ns30juNoZgMf5k1Sfg/K6clmb7IY
    Hb+Db8OAJuaEl3RV/k2YsLhDfRom44UA54x1VgHGVY0sXWSv/smDGY4kGqA663xW
    GKLMgTfMpiqvW8crrH1c/cCI4dxxMWWZ8vDehNVoowzVE65T8sQ+xltphTf+tN64
    FCC2rlEoHL7q50PbeeJIT49IkodEiCtWQ3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1522881044; bh=2kFGWWyfczyAPzcRxNMMBleGoi+yXL5qo6J/eUZ4pG
    0=; b=sNtC9Qjzd8h+Rrd5pkCsJofJoLwrV7/kv7omvxXsaRuuEF9sPVBv8Iq3AP
    IZTLUVPx1V4FfeHU4mb0LTcpxo+m1yI0ut/JLgegitRfEAJBoDGagydQRYy9dKd7
    b4CAm7fbFWtaxHSSBmMkKSdoLbLRp98mgesBYDGHe3E5eXcOemI7YqpGPHHlPbfi
    67eB0L6XIvUsn2Um23Rbbw1CPB5dT2FjVflD/EM2IXpuMSFkftKbuRexXr0vgpRa
    3TECsIZe4xxv2prSHOsSqmGiyUiTgK09FrAWd6AbZfVZVSXKrRy/2YujqTKzB5n1
    RW0fgdkuTePnyf0Tbb5+QB2rTJIw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfME8PQRB3mezvRWV9w3HSFKkpryF2Cs8U9Ll69SBKAWo8Zd0JgGLZifnWYM68JdVFUR0Sq0eA3qhn8FIySK+2H09ek1ADDqX4T2V/sJ+6nrSSu5UyJQ/
    /7Ctw065c0xcwmYf0cCfTFN+u05Un25YA3EN3KD1xH+P/+npm+iEOhNWV0U1YwC8mGYQlvWXf79Dx5MBfQwEokqGrExeGbDXIRkV2J3f0iTDhjciMIYpls6s
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=y-f6ONIPktPCHsBZRLEA:9
    a=ZKvKs6oBI42HQDF_:21 a=pIe9tz4Mi7jMKiXE:21 a=x8gzFH9gYPwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDDWan (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 18:30:43 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57675 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeDDWam (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 18:30:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
        <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
Date: Wed, 04 Apr 2018 17:29:30 -0500
In-Reply-To: <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com> (Nagarathnam
        Muthusamy's message of "Wed, 4 Apr 2018 13:31:32 -0700")
Message-ID: <87h8oqhagl.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3qvO-0001ak-Rq;;;mid=<87h8oqhagl.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19bOK6W7HUKVE0ybE/oB48tGTZ6E/GLy3I=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 1247 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (0.2%), b_tie_ro: 1.76 (0.1%), parse: 0.73 (0.1%),
        extract_message_metadata: 13 (1.0%), get_uri_detail_list: 1.52 (0.1%),
        tests_pri_-1000: 6 (0.5%), tests_pri_-950: 1.15 (0.1%), tests_pri_-900: 0.97
        (0.1%), tests_pri_-400: 23 (1.9%), check_bayes: 22 (1.8%), b_tokenize: 6
        (0.5%), b_tok_get_all: 8 (0.6%), b_comp_prob: 2.4 (0.2%), b_tok_touch_all:
        3.2 (0.3%), b_finish: 0.60 (0.0%), tests_pri_0: 1191 (95.5%),
        check_dkim_signature: 0.74 (0.1%), check_dkim_adsp: 3.3 (0.3%),
        tests_pri_500: 6 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:

> On 04/04/2018 12:11 PM, Konstantin Khlebnikov wrote:
>> Each process have different pids, one for each pid namespace it belongs.
>> When interaction happens within single pid-ns translation isn't required.
>> More complicated scenarios needs special handling.
>>
>> For example:
>> - reading pid-files or logs written inside container with pid namespace
>> - attaching with ptrace to tasks from different pid namespace
>> - passing pids across pid namespaces in any kind of API
>>
>> Currently there are several interfaces that could be used here:
>>
>> Pid namespaces are identified by inode number of /proc/[pid]/ns/pid.

Using the inode number in interfaces is not an option.  Especially not
withou referencing the device number for the filesystem as well.

>> Pids for nested Pid namespaces are shown in file /proc/[pid]/status.
>> In some cases conversion pid -> vpid could be easily done using this
>> information, but backward translation requires scanning all tasks.
>>
>> Unix socket automatically translates pid attached to SCM_CREDENTIALS.
>> This requires CAP_SYS_ADMIN for sending arbitrary pids and entering
>> into pid namespace, this expose process and could be insecure.
>>
>> This patch adds new syscall for converting pids between pid namespaces:
>>
>> pid_t translate_pid(pid_t pid, int source_type, int source,
>>                                 int target_type, int target);
>>
>> @source_type and @target_type defines type of following arguments:
>>
>> TRANSLATE_PID_CURRENT_PIDNS  - current pid namespace, argument is unused
>> TRANSLATE_PID_TASK_PIDNS     - task pid-ns, argument is task pid
>
> I believe using pid to represent the namespace has been already
> discussed in V1 of this patch in https://lkml.org/lkml/2015/9/22/1087
> after which we moved on to fd based version of this interface.

Or in short why is the case of pids important?

You Konstantin you almost said why they were important in your message
saying you were going to send this one.  However you don't explain in
your description why you want to identify pid namespaces by pid.

Eric
