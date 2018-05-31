Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754402AbeEaKJQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:09:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754290AbeEaKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:09:14 -0400
Date: Thu, 31 May 2018 15:39:03 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] error-injection: Simplify arch specific helpers
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
        <8f4883f08feaf6e040255015af2da7bbc7741e41.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
        <20180530174156.cb1799687fb834f26fe570a9@kernel.org>
In-Reply-To: <20180530174156.cb1799687fb834f26fe570a9@kernel.org>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18053110-0008-0000-0000-000002424F27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053110-0009-0000-0000-000021A7FA69
Message-Id: <1527761241.kc7z6i13ny.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=795 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Tue, 29 May 2018 18:06:02 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> We already have an arch-independent way to set the instruction pointer
>> with instruction_pointer_set(). Using this allows us to get rid of the
>> need for override_function_with_return() that each architecture has to
>> implement.
>> 
>> Furthermore, just_return_func() only has to encode arch-specific
>> assembly instructions to return from a function. Introduce a macro
>> ARCH_FUNC_RET to provide the arch-specific instruction and move over
>> just_return_func() to generic code.
>> 
>> With these changes, architectures that already support kprobes, only
>> just need to ensure they provide regs_set_return_value(), GET_IP() (for
>> instruction_pointer_set()), and ARCH_FUNC_RET to support error
>> injection.
> 
> Nice! the code basically good to me. Just one comment, ARCH_FUNC_RET sounds
> like a function. Maybe ARCH_RETURN_INSTRUCTION will be better name, isn't it? :)

Sure -- I thought of writing ARCH_FUNCTION_RETURN, but felt that was too 
verbose. How about ARCH_FUNC_RET_INST?

Thanks for the review,
Naveen
