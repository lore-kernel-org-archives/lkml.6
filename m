Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934805AbeBMQWC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:22:02 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:41295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934472AbeBMQWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:22:00 -0500
Subject: Re: RFC: build config via DT names
To: Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: "Enrico Weigelt, metux IT consult" <metux@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <63f25fea-f163-f9cc-b5b2-f6f291d7f8d2@gmx.de>
 <d55f95cc-228b-e65f-b46c-2f314f4fa582@gmail.com>
 <CAL_JsqJXJA+Z7b6SoUx=MVK_C=vcMRAibapriOi+Wss6L1ahsw@mail.gmail.com>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <fcaefa19-defc-f09d-fa55-06384e2a545d@metux.net>
Date: Tue, 13 Feb 2018 16:21:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJXJA+Z7b6SoUx=MVK_C=vcMRAibapriOi+Wss6L1ahsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:7H28iPK7soWdQhNvhkmnk10i/9yb3RARvpfwmFOAFVHdmgmiB8w
 dRngvNYPDgydsqlXZ09YCLHistEO9/kuxiSWVYcARdjXpGAMeGGZhnr/vgnT7bs9vY3AIFd
 yWL6v9NbSldKRcUgiZ5SGNUcmThSq6tKQqXOvded4B2erID7GqtH/ik1RBPpwQb1SxKSlJk
 VNPHZArVIM3gWY4ut+a0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fADO9O2LA1U=:VzPqGobCNVCm+aPSL7cynS
 XRDDbB31c3ZqhR9iI4W/YtifkrnTopQAbG5XGYXxUFg2fWmuDYuGA3QmItZQsssz5IShAhnac
 gPRk2NP19XwWeCGvL1OyvsVH28nnMVCIE049M4BVl41HBmVZvkH/65loWqZLmpTS+SlW8mpNM
 KCgx0aD7lWw0nWnCC0Duw4a+M0jC1EgAhSAXcioiZd4XwfK/2ZmMHUG62I2nxW6suFf7y48Ip
 Zn/u/L3jJpfjGfY7tu68bqlJFFXVxQFmwkSAk4Kp8uwdR81ZCYUi+rWZTHqdUX6RotR8lGnRN
 TdehQ0BWaIxILDmwIUEnYbFCbXjNsNW/8qjwAdfxBdm9Mpr8NUlzWKDHoFIIeyVPPYRrB8ZfX
 d/30fRj4qSYhlsBFdp4ytRRuhTyVGh/09pU1JGWPp1O0ybPODzh0jqOxUPOD7MT2aKVLhN1Ie
 H4XHTuPc/GxuGPq/KcxqJ/x+kSSIb3qjliZsFtgRIlfTb0NTI2jjwGcnSje0gJq6k2mI5lDUi
 EA79ITDE3PkpFDSQ2p+qTlbXEZuJUFaayHjg0AqCsW8DJSHBq1J5c9OcNUxkF7KydJF5humNA
 BIp1qvAgtP6l+kpjtC4ezzekFsLXbD9jsiSbRfdJIU4ggug7tm23V7LPvj2fS4lpSz7W+Jl7n
 VvAsZBJDbso2CJkVNSlrZXXL6mHj/YW9dxCeNVbykI4dNZ3xi6Rbs6YjuLKSmZvGgxUcECBMU
 KAVIEw8WDOyJbzrQK16K6F4ZmB062sCGivCY7li7SRMJasFY86Hd/YQv8xs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2018 15:19, Rob Herring wrote:

> Doubling the number of driver config options is not going to fly. 

These options would be in their own submenu (which could be disabled
completely) and use their own prefix. IMHO, even if they grow into big
numbers, the impact should be minimal.

> How would you handle multiple compatible strings per driver? 

Multiple entries in the submenu, each selecting the same driver.

> We have all the data, so we should be able to generate this which
> dt_to_config tries to do. 

I guess there're lots of corner cases that would need special magic.

> I think part of the problem is dt_to_config
> works at the source level for everything. Really we need a more robust
> way to map source files to config options and extracting match tables
> from drivers. Perhaps doing the latter with coccinelle which can match
> struct types, using the object files instead, or using module aliases
> (though that doesn't work for built-in drivers).

Configure by already compiled binaries ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
