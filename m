Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeDETRk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:17:40 -0400
Received: from mout.web.de ([212.227.17.12]:43949 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeDETRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:17:38 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <CAL_Jsq+Gu=gwcxJnOF2xybXCh9N2Fp1NV05kuvQ2rif1fdHYrA@mail.gmail.com>
 <de44758c-6c40-b951-e235-b2307ae6257e@gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <48bb616d-000f-834c-fcfd-c5441a6b61d8@web.de>
Date: Thu, 5 Apr 2018 21:17:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <de44758c-6c40-b951-e235-b2307ae6257e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kpS+aJ0puJkuvR3mySuL3JaiLZ1QCPooJ5ha7iXo+upLcVcWJHK
 8KsIB2R/32BF0kjgjPqV53kIfHBk28raGd/HJrdwuHcMC0rkYh205hdObmdH3cLTye4IcGJ
 UKCSnt/uX9kzFcPT+almnUgjIpcOsx+3ZUfY+WKZ8JgBe/ISzfx+gkyzXbWhb4Fcsip6sMT
 1ikVwQJJsuny6sDMkNPbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NNhQUYAVCjA=:avFpjue361zZZa1nJNg5jj
 AHEdpT8CeytwBmvF7RXUSHQuca0XBwX9cePdVNDirLKuLp3LhqvSaTllloIBMoZR6C+p7IX39
 KMVESUbt6OfpoDuZV64dJLKPpYG5o7Kc8Pcf6HSnRgZ+9eqAraDtzXWKfTxf6XFZoCrwakNjJ
 yZkISficFUSdRBQAw+DUXauR6OVsOOcBQiSwXYpMSdxq25mPYohThesWGyHoi9SW8hCh7oUj3
 uxp/fTCOfD/zBjbWWm25vMJFRNveOfTCauPS1uCP03GBxgV7UoLYjKlj7egJCm2fXQgxLRagf
 uDVY7ds2qxZQVmQ9gYJiRGTsZogDY/p5NmIh6HwVZd2NS3HDTb+b+C/S/Pu01B3VUWsFTIp6Z
 o5e5SJNsr/+MNTTzpKfjWaBKdYUdQHRurCQj0r5RoDr+RC0PrLuPRE0+ooHVPbyKafggpgPWo
 CgsUcW4WZw4T0GWLGBvIR4FA8ROpK5KzI4zPUyJFWcqSa+6uXNC7paagT51xj836SKauCmkDr
 DZDhL0M4wGjAwNreJeRpbH2LR/zOwu29UGL1cd4Z97GB2fOtE3x9aSrsJJRl0lJAIIQVg2ZdB
 ZLPzhpWs4sVvb1lK+8uzwCazn2a2wKUjqd8G7pCfTOt4YlNrg+MQF0GzbkuRPA1MN9dPTDWNI
 ADUcT4ocW7XxMx6yqUvEMFKRqefwPTp7A5mZV9GWWTHZQRQm60jpLXvJxSbgC0zgrVcvDR98f
 zrLb6z5s0lI9kDNS8PoQZ4W7vwQY0hI7ugw5JBa4KVuI6iGfZjH7R7U++GE7OImabvRhX2VZI
 /Sxgkyv2izMMZ16EMlpc4UyP2eWfRY4uqcLfdBRalXf90M1jqQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-05 21:13, Frank Rowand wrote:
> On 04/04/18 17:55, Rob Herring wrote:
>> On Wed, Apr 4, 2018 at 5:35 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>>> Hi Frank,
>>>
>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>> (FDT) into the overlay application code.  To accomplish this,
>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>
>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>> original FDT.
>>>>
>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>> thus responsible for freeing the unflattened devicetree.
>>>>
>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>> or the unflattened devicetree, which could result in use after free
>>>> errors.
>>>>
>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>> overlay loader.
>>>
>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>> device during hypervisor activation with Linux. The DT overlay is
>>> created from a a template but modified prior to application to account
>>> for runtime-specific parameters. See [1] for the current implementation.
>>>
>>> I'm now wondering how to model that scenario best with the new API.
>>> Given that the loader lost ownership of the unflattened tree but the
>>> modification API exist only for the that DT state, I'm not yet seeing a
>>> clear solution. Should we apply the template in disabled form (status =
>>> "disabled"), modify it, and then activate it while it is already applied?
>>
>> No. I don't think that will work.
> 
> I don't think it will work either.  The drivers won't be probed if the
> nodes are disabled.
> 

That would be the purpose of registering it disabled. The question is:
Would it be probed at the point when we enabled it while being applied?
If not, strike this.

Jan
