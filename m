Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeEDQKy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:10:54 -0400
Received: from mout.web.de ([212.227.17.12]:44033 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751326AbeEDQKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:10:52 -0400
Subject: Re: [v3] [media] Use common error handling code in 19 functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andi Shyti <andi.shyti@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Utkin <andrey_utkin@fastmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Brian Johnson <brijohn@gmail.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph@boehmwalder.at>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Colin Ian King <colin.king@canonical.com>,
        Daniele Nicolodi <daniele@grinta.net>,
        =?UTF-8?Q?David_H=c3=a4rdeman?= <david@hardeman.nu>,
        Devendra Sharma <devendra.sharma9091@gmail.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Inki Dae <inki.dae@samsung.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Max Kellermann <max.kellermann@gmail.com>,
        Mike Isely <isely@pobox.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Santosh Kumar Singh <kumar.san1093@gmail.com>,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Sean Young <sean@mess.org>, Seung-Woo Kim <sw0312.kim@samsung.com>,
        Shyam Saini <mayhs11saini@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <227d2d7c-5aee-1190-1624-26596a048d9c@users.sourceforge.net>
 <57ef3a56-2578-1d5f-1268-348b49b0c573@users.sourceforge.net>
Openpgp: preference=signencrypt
Message-ID: <9e766f52-b09e-c61e-8d9f-23542d83f6b1@users.sourceforge.net>
Date: Fri, 4 May 2018 18:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <57ef3a56-2578-1d5f-1268-348b49b0c573@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QQrN3vdOkrQJ7KUlpS2UmbJnepEgLXRM95PWjS6cleNRuixMJdm
 S5QvHdzCGrUp5wixzO/yGikqdZUD7y+3YqJ1uD0pWtirzleExLGj86LBjyFeVyADgeteOid
 +6gkt6HyKYqHo/dmgWOWBS7jXZy6+IamF6izoEEa4Er251szZKmn7vcEEkw/jHKQBptdcpA
 Y7u3biir90yUo07dvonIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SC3yT0f/DxY=:OJiHWhLrTL/ijFk1MF0kxL
 n0ajY0RqF+tN76+/DyrRWlYS3gXYxz92KRBY6p+LMwyTenWx5QW606W9Lw4qWBWR+h4YDM/VJ
 WLvpkAKznyHX+b3oFHCv9tmATTVrH/5HfvOtouGHCPu2RCPRL3YHIi/M5EzbL+om+tnCFp6ib
 AHgbyETlkaVrjzvEe3L0acKjzG4p3sUpPmhyGBRk29rxIRiyTsdVPtD8aEz8WThJmfBKO2EXr
 QsbdfEYRpTrDDdroL/ANmLS/6MHMQB8HTfHtS+acHeQi95FqyWJoZ1DuLMO5d+GkVZx1eC2hx
 RFevsgqUGy41tfoOhKOWc/BpIFI7HRraX1ZhHks74woOyWAxZ1ozwAiY90BINfRRLwJL0JYn1
 hGEJaW/B8USNu+FiKoMQ77Nqr+c2xE0dY5SOvLsZKfulJILJhy0MyOByGTun3ZJ0zrEG0oQFx
 u4wLCglKv3Jxt3dzTLHPZS9nm+vtlAbTY03aInatXDzYb2MovFO7e9PNHgviNtI51HT0HfM29
 ZvZTBgIy23igRAiuK0Knfjij+SfMFN0ubK7naPYsWEG3au1e2NMcHNlmHDnv18aYGRq6roco2
 lU5uwfFbedIoWPZV4Lj9Sku0sB0zNlcJrFLXaMtH7GzYGY5Tg4adm78qEvWsD1feZNCFU/lpR
 1RSrQaiM6sDKrKiiUkF0eQvsZ+4OlzybKv/tXINeqT2fhCikzMp3ijfDhBCgUv28YpbHrY/qM
 cUfurrJM3y8QlHD+QvesmZprUfTinvi9YXLMu/XYSi3FmObL3YcFM2wSuBT8yi82+AXIG7uN2
 j+b+LnI
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Adjust jump targets so that a bit of exception handling can be better
> reused at the end of these functions.

Why was this update suggestion rejected once more a moment ago?

https://patchwork.linuxtv.org/patch/47827/
lkml.kernel.org/r/<57ef3a56-2578-1d5f-1268-348b49b0c573@users.sourceforge.net>
https://lkml.org/lkml/2018/3/9/823

Would you like to integrate such a source code transformation after any further adjustments?

Regards,
Markus
