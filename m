Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeB0HZh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:25:37 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35151 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeB0HZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:25:35 -0500
X-Google-Smtp-Source: AG47ELvz4j/BvFwzlhPYrMlJcHdfGyc22V2mfw4tbJaVoXB+sco4XCfqHm9+Wd49uePXbFdPu7BeORYD/Wvgnk68O2M=
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com> <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 27 Feb 2018 08:25:14 +0100
X-Google-Sender-Auth: jUGoakTXuAH2crh6sOietVDvD3U
Message-ID: <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 3:45 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Feb 26, 2018 at 4:44 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org> wrote:
>
>>>  static void __init check_cpu_feature_properties(unsigned long node)
>>>  {
>>> -       unsigned long i;
>>>         struct feature_property *fp = feature_properties;
>>>         const __be32 *prop;
>>>
>>
>> Much simpler is just add
>>
>> if (ARRAY_SIZE() == 0)
>>  return;
>>
>>> -       for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>>> +       for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {
>
> ...or convert to while(), which will be more readable.

So you'd prefer something like:

while (fp < feature_properties + ARRAY_SIZE(feature_properties)) {
  ...
  ++fp;
}

right ?
