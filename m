Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1E4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773BB20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773BB20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbeGIQay (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:30:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:49102 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeGIQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:30:53 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcZ3n-0000kI-PK; Mon, 09 Jul 2018 18:30:47 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcZ3n-000DUm-Kc; Mon, 09 Jul 2018 18:30:47 +0200
Subject: Re: kernel BUG at mm/slab.c:LINE! (2)
To:     Dmitry Vyukov <dvyukov@google.com>,
        Christopher Lameter <cl@linux.com>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>
Cc:     syzbot <syzbot+885bda95271928dc24eb@syzkaller.appspotmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000afa87d05708af289@google.com>
 <010001647fcab0b9-1154d4da-94f8-404e-8898-b8acdf366592-000000@email.amazonses.com>
 <CACT4Y+ZiVLw4pEt_GXV0DDo95eER5LuwXRo_fjFLwP8fUXzcrQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <35087252-a5fa-c162-efb2-aa2b6a30515a@iogearbox.net>
Date:   Mon, 9 Jul 2018 18:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZiVLw4pEt_GXV0DDo95eER5LuwXRo_fjFLwP8fUXzcrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24737/Mon Jul  9 14:40:44 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 06:16 PM, Dmitry Vyukov wrote:
> On Mon, Jul 9, 2018 at 6:05 PM, Christopher Lameter <cl@linux.com> wrote:
>> On Sun, 8 Jul 2018, syzbot wrote:
>>
>>> kernel BUG at mm/slab.c:4421!
>>
>> Classic location that indicates memory corruption. Can we rerun this with
>> CONFIG_SLAB_DEBUG? Alternatively use SLUB debugging for better debugging
>> without rebuilding.
> 
> This runs with KASAN which is way more powerful than slab/slub debug.
> 
> There two other recent crashes in bpf_test_finish which has more info:
> 
> https://syzkaller.appspot.com/bug?id=f831c88feddf5f4de09b846bbe53e5b8c06e5c02
> https://syzkaller.appspot.com/bug?id=059cee5623ce519359e7440ba6d0d6af8b82694e

Fyi, looking into the two today as well.
