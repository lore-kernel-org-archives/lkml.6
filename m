Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223322-1521649185-2-17509912070426126653
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521649184; b=otrl8bz0VgxajhmhyTTJg0MaFyp2DMk0rK8JhsBTnCnjY0N
    UDHVedwpj8gmSIgwYlc0/K35pyGRL+PKszfILdLhgMBda6FjNJfIT/hQlvypAjL0
    LhsAMEkKQ0ytdLBd431PzfJ7g0w8Ll+IQSiyTE6oaKPxn4RUufRXzap1S5zpmLIv
    KJniq9t71j8pk0BuQN68TXvbnzq9ezvODuxsiQnUhkPqQkwC/5At8YqKHIEfO7zR
    IwYcucAnZQtFO6cgFehYJRLucxtFepB3R/peQtiqQA8GoVuzZGP9LBg5ObmFZYHC
    jRiBxu/5kfsE6OwnL4tB4D9ESD0M64qWR/AFJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521649184; bh=Obqk2uWSEmbm7U5jDonxuOy0cnMIr2zkmEW8yH
    GPD1k=; b=h2Ki+dOzsJx+2EJzpBR5l1Gnc+liQyIsjzelvT7+PVQ5FYQMpIueg7
    C6TF6gEr45ZQTE1LIocolHIvKEGJK7cVa2zXOxEfsXTcGlmB6liNofoVKxcwKSTC
    QAttMCTw9LoQDuoM2sY6pD3D0UsnVKQVhnTyL2+clTmjWY46hFpQrnSYsllqEXGY
    c7F28oFagrqQ/tAAv/tyWIR6XclChRZEnV72cx+iuG1adXipVFQsWnIxzPn5wFUf
    NifTBlrRRUwb/6QcvhQ0BMnNbDa/ycc7kjgcjB35JAO4kYM6egmbUpl14WIdw55f
    hxFDz/MbKol2KDlRMtp7HxJaiBVmyJ6A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IUmfekqG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IUmfekqG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeCUQTm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:19:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50655 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCUQTl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 12:19:41 -0400
X-Google-Smtp-Source: AG47ELsfpTg3/qQkm0mopEvXHMiIPtnHGFj3bTBCx15vTarF7Ru47SfezX49AfpZnX8K8sEPFK59/A==
MIME-Version: 1.0
In-Reply-To: <20180321161437.smb5mniyridguw4x@sasha-lappy>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-109-alexander.levin@microsoft.com> <CAGb2v67rPBSPy8e8CXtWzwKW8eeqjj=JyTnYPNH5mJ01yB7haw@mail.gmail.com>
 <20180321161437.smb5mniyridguw4x@sasha-lappy>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 22 Mar 2018 00:19:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v67fYPAXV5PoriJO+PLjVOJQ3QisQsQL9BGYMv0itGFQvQ@mail.gmail.com>
Message-ID: <CAGb2v67fYPAXV5PoriJO+PLjVOJQ3QisQsQL9BGYMv0itGFQvQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.9 109/219] clk: sunxi-ng: a33: Add offset
 and minimum value for DDR1 PLL N factor
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 12:14 AM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> On Tue, Mar 20, 2018 at 11:10:42AM +0800, Chen-Yu Tsai wrote:
>>Hi,
>>
>>On Sun, Mar 4, 2018 at 6:28 AM, Sasha Levin
>><Alexander.Levin@microsoft.com> wrote:
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> [ Upstream commit 68f37d862403e8f95337b2eca90af15d0b8cd5d7 ]
>>>
>>> The DDR1 PLL on the A33 is an oddball amongst the A33 CCU clocks.
>>> It is a clock multiplier, with the effective multiplier in the
>>> range of 12 ~ 255 and no offset between the multiplier value and
>>> the value programmed into the register.
>>>
>>> Implement the zero offset and minimum value of 12 for this clock.
>>>
>>> Fixes: d05c748bd730 ("clk: sunxi-ng: Add A33 CCU support")
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>> ---
>>>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 18 +++++++++++-------
>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
>>> index e1dc4e5b34e1..bdbaf26f551f 100644
>>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
>>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
>>> @@ -159,13 +159,17 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
>>>                                         BIT(28),        /* lock */
>>>                                         CLK_SET_RATE_UNGATE);
>>>
>>> -/* TODO: Fix N */
>>> -static SUNXI_CCU_N_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
>>> -                                 "osc24M", 0x04c,
>>> -                                 8, 6,                 /* N */
>>> -                                 BIT(31),              /* gate */
>>> -                                 BIT(28),              /* lock */
>>> -                                 CLK_SET_RATE_UNGATE);
>>> +static struct ccu_mult pll_ddr1_clk = {
>>> +       .enable = BIT(31),
>>> +       .lock   = BIT(28),
>>
>>As you undoubtedly noticed, this does not build. It needs commit
>>cf719012b232 ("clk: sunxi-ng: mult: Support PLL lock detection")
>>to be applied first. They were part of the same series.
>
> Thanks for the heads up!
>
>>Incidentally, how can we note these kinds of dependencies to make
>>life easier for stable kernel maintainers?
>
> Yes! There are more details in Documentation/process/stable-kernel-rules.rst:
>
>
> """
> Additionally, some patches submitted via Option 1 may have additional patch
> prerequisites which can be cherry-picked. This can be specified in the following
> format in the sign-off area:
>
>      Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
>      Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
>      Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
>      Cc: <stable@vger.kernel.org> # 3.3.x
>      Signed-off-by: Ingo Molnar <mingo@elte.hu>
>
> The tag sequence has the meaning of:
>
>      git cherry-pick a1f84a3
>      git cherry-pick 1b9508f
>      git cherry-pick fd21073
>      git cherry-pick <this commit>
> """

I know about these, and add them when I can. What I'm asking about is
if a fix and its prerequisites are sent as part of a larger series for
-next, then none of the prerequisites would be in Linus' tree, and I
can't use this format. What then? Mention the prerequisite patches'
subjects in the commit log?

We tend to bunch fixes into -next if they aren't critical (such as
a faulty clock that doesn't have any in tree users yet) or related
to the current -rc series.

Thanks
ChenYu
