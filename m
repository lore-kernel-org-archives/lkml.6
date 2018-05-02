Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-437838-1525248849-2-16418467083293229340
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525248849; b=hvSsZnRU07f47kai76NWbJU4ZuMKtR+AGeBW6W5sTQwopFUOsu
    rcGiSC74mBtXMI71JrlifOmU5h2VWp3b1C3KyXE6YX2EJxXE2FYHxfzoEFZOyJzA
    pcJLGoQW6Gej6lRjpWA1dzC/4nak0kTegjLgtqC7ZQ3Ftew810n8KUvcGonq5y+I
    tVvplFKP77IaxKGrlfBXGSaVu3cZXV9N5jCYKst5WzsBi+kA43B8XieJgm2isnGz
    0ujOifovyOLKH95BFem3/ty622E/JusNKohU7o5NIZ3Cnwh6boqlCednJuAjZQxe
    /HIas6RT8EJ+AYwiy2u1cAJFd5X07Vehxwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1525248849; bh=Ru5N++FnKO58
    qqtDF0YcEhXpsVrfKxqujLzqjjC/GSY=; b=Giqg4WJXP6sC6zwNJX85seRPtyKb
    yt5ajQDtFEVy+sbn+4YAJaGCXFewLVI4+lX6qYBhtrzALzx43ezBP1cQfxn5qVDb
    HPpVbF1xEbN1ylgyH0oYQZdAKXqYQYNT8G+bnfdMOayMD+ANu0c2errhmkjj5iZz
    TyFn5Q+lEUJzDt+Bu4RzHzg4JX8x7NDN0Cn3nZvATpyzMwI5OuwrLNmlKF06iMAp
    QgHcXaBNV11ml9vEsU5HxmL8u5KS769Ue+Wp+Ex7V9fqxYTiF55hFz0OwMkn+Lo6
    AG4Iqb4wbJOKPDmF6+HCZxM7nwm3PI07g0jZl2eKN2ml+xZx3Pu1aA6x0A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP1L1CsREkDg8VTyOTIAhLpO7rPZ/TpXbIo6lX6f7jlr2WYfLfct0HzAJmNshZapKElSeV5K9DsYccLHIVnYh+7j6p4bRIuGe6MccD1F2XcOHJeeUeqk
    R/qJn6tug2GmwLUivhyKbVtaDjlGzmRtI280GBH2eYUPtwVipu0kdbG4c5ZPS9wbrhGv87I0+shzmL1W/R7LzVljiQrBkWrXC16TKD+E78rglCGf83f0PW2U
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=vZXdsOsssTSAQrUsAlUA:9
    a=PeZ-iBFPp7N9trSQ:21 a=XwJyiYZwJLO_Y6Ev:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750883AbeEBINr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 04:13:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751188AbeEBINq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 04:13:46 -0400
Subject: Re: [PATCH v3] module: Fix display of wrong module .text address
To: Kees Cook <keescook@chromium.org>
Cc: Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        brueckner@linux.vnet.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        "# 3.4.x" <stable@vger.kernel.org>
References: <20180418071436.21392-1-tmricht@linux.ibm.com>
 <CAGXu5j+wnRsecDVZjOFVmLLdptfqSJ2QCLAY-x+EaiUAd0yfjA@mail.gmail.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Wed, 2 May 2018 10:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+wnRsecDVZjOFVmLLdptfqSJ2QCLAY-x+EaiUAd0yfjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050208-0020-0000-0000-00000418098D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050208-0021-0000-0000-000042AD2441
Message-Id: <024d902c-54d7-f91e-4d71-57da4b15b3f9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020074
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/02/2018 04:20 AM, Kees Cook wrote:
> On Wed, Apr 18, 2018 at 12:14 AM, Thomas Richter <tmricht@linux.ibm.com> wrote:
>> Reading file /proc/modules shows the correct address:
>> [root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
>> qeth_l2 94208 1 - Live 0x000003ff80401000
>>
>> and reading file /sys/module/qeth_l2/sections/.text
>> [root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
>> 0x0000000018ea8363
>> displays a random address.
>>
>> This breaks the perf tool which uses this address on s390
>> to calculate start of .text section in memory.
>>
>> Fix this by printing the correct (unhashed) address.
>>
>> Thanks to Jessica Yu for helping on this.
>>
>> Fixes: ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
>> Cc: <stable@vger.kernel.org> # v4.15+
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: Jessica Yu <jeyu@kernel.org>
>> ---
>>  kernel/module.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index a6e43a5806a1..40b42000bd80 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -1472,7 +1472,8 @@ static ssize_t module_sect_show(struct module_attribute *mattr,
>>  {
>>         struct module_sect_attr *sattr =
>>                 container_of(mattr, struct module_sect_attr, mattr);
>> -       return sprintf(buf, "0x%pK\n", (void *)sattr->address);
>> +       return sprintf(buf, "0x%px\n", kptr_restrict < 2 ?
>> +                      (void *)sattr->address : NULL);
> 
> Errr... this looks reversed to me.
> 
> I would expect: "kptr_restrict < 2 ? NULL : (void *)sattr->address"
> 
> -Kees
> 

I am confused:
In my patch, if kptr_restrict == 2 it prints NULL, which kptr_restrict 
being 0 or 1 it prints the address.

In your comment if kptr_restrict == 2 it prints the address, which 
kptr_restrict being 0 or 1 it prints NULL.

Looking into Documentation/sysctl/kernel.txt:
  When kptr_restrict is set to (2), kernel pointers printed using
  %pK will be replaced with 0's regardless of privileges.

With my patch, setting kptr_restrict to 0 or 1
prints the real kernel address (format %px, unmodified address
according to Documentation/printk-formats.txt).

I have tested this on s390 (which is the only arch using file
/sys/module/<XXX>/sections/.text) in the perf tool.

root@s8360047 ~]# sysctl  kernel.kptr_restrict
kernel.kptr_restrict = 0
[root@s8360047 ~]# cat /proc/modules | egrep '^qeth_l2'
qeth_l2 102400 1 - Live 0x000003ff8034d000
[root@s8360047 ~]# cat /sys/module/qeth_l2/sections/.text 
0x000003ff8034da68
[root@s8360047 ~]# sysctl  -w kernel.kptr_restrict=2
kernel.kptr_restrict = 2
[root@s8360047 ~]# cat /proc/modules | egrep '^qeth_l2'
qeth_l2 102400 1 - Live 0x0000000000000000
[root@s8360047 ~]# cat /sys/module/qeth_l2/sections/.text 
0x0000000000000000
[root@s8360047 ~]# uname -a
Linux s8360047 4.17.0-rc3m-perf+ #6 SMP PREEMPT Wed May 2 10:02:38 CEST 2018 s390x s390x s390x GNU/Linux
[root@s8360047 ~]# 

Hope this helps.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
