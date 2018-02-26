Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbeBZOpp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:45:45 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:44700 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbeBZOpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:45:42 -0500
X-Google-Smtp-Source: AG47ELtussXPov9GGLx6J74euQo3VY6vMz5pCsunnghKBE0Cwmb5DhkvtNmwYGZSenNATMD4Mu6JZ9fCCBOSuwffy/0=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:45:41 +0200
Message-ID: <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Mathieu Malaterre <malat@debian.org>
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

On Mon, Feb 26, 2018 at 4:44 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org> wrote:

>>  static void __init check_cpu_feature_properties(unsigned long node)
>>  {
>> -       unsigned long i;
>>         struct feature_property *fp = feature_properties;
>>         const __be32 *prop;
>>
>
> Much simpler is just add
>
> if (ARRAY_SIZE() == 0)
>  return;
>
>> -       for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>> +       for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {

...or convert to while(), which will be more readable.

-- 
With Best Regards,
Andy Shevchenko
