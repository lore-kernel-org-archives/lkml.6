Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeCRFA1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 01:00:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750756AbeCRFA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 01:00:26 -0400
From: gengdongjiu <gengdongjiu@huawei.com>
To: James Morse <james.morse@arm.com>, gengdongjiu <gengdj.1984@gmail.com>
CC: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "Huangshaoyu (Shawn)" <huangshaoyu@huawei.com>
Subject: Re: [PATCH] arm64: rename the function arm64_is_ras_serror() to
 avoid confusion
Thread-Topic: [PATCH] arm64: rename the function arm64_is_ras_serror() to
 avoid confusion
Thread-Index: AdO+dXEZOYZcXfBPRxK9auxbihsfMg==
Date: Sun, 18 Mar 2018 05:00:10 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201B6C1B2@DGGEMA503-MBS.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.52.52]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2I50ifm024173

Hi James,

> Hi gengdongjiu,
> 
> On 26/02/18 16:13, gengdongjiu wrote:
> > 2018-02-24 1:58 GMT+08:00 James Morse <james.morse@arm.com>:
> >> On 22/02/18 18:02, Dongjiu Geng wrote:
> >>> The RAS SError Syndrome can be Implementation-Defined,
> >>> arm64_is_ras_serror() is used to judge whether it is RAS SError, but
> >>> arm64_is_ras_serror() does not include this judgement. In order to
> >>> avoid function name confusion, we rename the arm64_is_ras_serror()
> >>> to arm64_is_categorized_ras_serror(), this function is used to judge
> >>> whether it is categorized RAS Serror.
> >>
> >> I don't see how 'categorized' is relevant. The most significant ISS
> >> bit is used to determine if this is an IMP-DEF ESR, or one that uses the architected layout.
> >
> > From the name arm64_is_ras_serror(), it used to judge whether this is
> > RAS Serror, but arm64_is_ras_serror() think the IMP-DEF SError is not
> > RAS SError, as shown the code note and code in[1].
> 
> > In fact the IMP-DEF SError is also RAS SError, so when I read the
> > code, it looks like
> 
> This is just you then. No-one else has your imp-def:RAS error ESR values.
> 
> This would be like me adding some impdef branch instruction, then claiming
> aarch64_insn_is_branch() doesn't take account of my private additions.
> 
> I agree the name is assuming all architected ESR are RAS-errors, and that impdef ESR are just that: impdef, that's all we know about them.
> Unless this causes us to do the wrong thing, I don't think it matters.
> Obviously we would need to change it if a new architected ESR is added.

Ok, let us keep the current code and not change it until a new architected ESR is added
