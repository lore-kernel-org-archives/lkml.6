Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F374BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A588D2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A588D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbeGKIrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:47:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbeGKIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:47:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6B8iFPT106980
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:44:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5bwyp131-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:44:38 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 11 Jul 2018 09:44:35 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 09:44:30 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6B8iT4T39583928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 08:44:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2885511C052;
        Wed, 11 Jul 2018 11:44:51 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F7411C05E;
        Wed, 11 Jul 2018 11:44:47 +0100 (BST)
Received: from [9.124.31.141] (unknown [9.124.31.141])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 11:44:47 +0100 (BST)
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>, srikar@linux.vnet.ibm.com
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
 <20180710152527.GA3616@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 11 Jul 2018 14:14:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710152527.GA3616@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071108-4275-0000-0000-000002975D46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071108-4276-0000-0000-0000379EFBDC
Message-Id: <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 07/10/2018 08:55 PM, Oleg Nesterov wrote:
> Hi Ravi,
> 
> On 07/04, Ravi Bangoria wrote:
>>
>>> Now I understand what did you mean by "for each consumer". So if we move this logic
>>> into install/remove_breakpoint as I tried to suggest, we will also need another error
>>> code for the case when verify_opcode() returns false.
>>
>> Ok so if we can use verify_opcode() inside install_breakpoint(), we can probably
>> move implementation logic in install/remove_breakpoint(). Let me explore that more.
> 
> No, sorry for confusion, I meant another thing... But please forget. If we rely on
> verify_opcode() I no longer think it would be more clean to move this logic into
> install/remove_breakpoint.
> 
> However, I still think it would be better to avoid uprobe exporting and modifying
> set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
> I'll re-check...

Good that you bring this up. Actually, we can implement same logic
without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
in uprobe_write_opcode(). No need to export struct uprobe outside,
no need to change set_swbp() / set_orig_insn() syntax. Just that we
need to pass arch_uprobe object to uprobe_write_opcode().


But, I wanted to discuss about making ref_ctr_offset a uprobe property
or a consumer property, before posting v6:

If we make it a consumer property, the design becomes flexible for
user. User will have an option to either depend on kernel to handle
reference counter or he can create normal uprobe and manipulate
reference counter on his own. This will not require any changes to
existing tools. With this approach we need to increment / decrement
reference counter for each consumer. But, because of the fact that our
install_breakpoint() / remove_breakpoint() are not balanced, we have
to keep track of which reference counter have been updated in which
mm, for which uprobe and for which consumer. I.e. Maintain a list of
{uprobe, consumer, mm}. This will make kernel implementation quite
complex because there are chances of races. What we gain in return
is flexibility for users. Please let me know if there are any other
advantages of this approach.

By making it a uprobe property, we are forcing user to use
uprobe_register_refctr() for uprobes having reference counter. Because
we don't allow same uprobe with multiple reference counter and thus
user can't use both uprobe_register_refctr() and uprobe_register() in
parallel for same uprobe. Which means user does not have a flexibility
to create normal uprobe with uprobe_register() and maintain reference
counter on his own. But kernel implementation becomes simple with this
approach. Though, this will require changes in tools which already
supports SDT events, systemtap and bcc I'm aware of. But AFAICS, the
change should not be major. In fact, the change should make tool code
simpler because they don't have to worry about maintaining reference
counter.

Third options: How about allowing 0 as a special value for reference
counter? I mean allow uprobe_register() and uprobe_register_refctr()
in parallel but do not allow two uprobe_register_refctr() with two
different reference counter. If we can do this, the issue of forcing
legacy user to use uprobe_register_refctr() will be solved. I.e. no
change needed on tools side and still kernel implementation will
remain simple. I'll explore this option.

Let me know your thoughts.

Thanks,
Ravi

PS: We can't abuse MSB with first approach because any userspace tool
can also abuse MSB in parallel. Probably, we can abuse MSB in second
and third approach, though, there is no need to.

