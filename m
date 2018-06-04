Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeFDClZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 22:41:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45607 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeFDClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 22:41:24 -0400
X-Google-Smtp-Source: ADUXVKI4d2QoPLXTNJ/Rrmjj58ZcuYbjuflmcX/hcoqkjbGf/Yrn9S+0Cdypn2K60m1paMLNGC72LdO1FSd7y2cPRWg=
MIME-Version: 1.0
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com> <20180603124941.GA29497@rapoport-lnx>
 <CAHCio2ifo3SNH9E3GX2=q1a=MNiNnoCu+2a++yX5_xMBheya5g@mail.gmail.com>
In-Reply-To: <CAHCio2ifo3SNH9E3GX2=q1a=MNiNnoCu+2a++yX5_xMBheya5g@mail.gmail.com>
From: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date: Mon, 4 Jun 2018 10:41:10 +0800
Message-ID: <CAHCio2in8NXZRanE9MS0VsSZxKaSvTy96TF59hODoNCxuQTz5A@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Refactor part of the oom report in dump_header
To: rppt@linux.vnet.ibm.com
Cc: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w542fVd2005293

Hi Tetsuo
> Since origin_memcg_name is printed for both memcg OOM and !memcg OOM, it is strange that origin_memcg_name is updated only when memcg != NULL. Have you really tested !memcg OOM case?

if memcg == NULL , origin_memcg_name will also be NULL, so the length
of it is 0. origin_memcg_name will be "(null)". I've tested !memcg OOM
case with CONFIG_MEMCG and !CONFIG_MEMCG, and found nothing wrong.

Thanks
Wind
禹舟键 <ufo19890607@gmail.com> 于2018年6月4日周一 上午9:58写道：
>
> Hi Mike
> > Please keep the brief description of the function actually brief and move the detailed explanation after the parameters description.
> Thanks for your advice.
>
> > The allocation constraint is detected by the dump_header() callers, why not just use it here?
> David suggest that constraint need to be printed in the oom report, so
> I add the enum variable in this function.
>
> Thanks
> Wind
