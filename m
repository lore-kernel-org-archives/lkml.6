Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1CDC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A507B20844
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfBLAH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:07:27 -0500
Received: from namei.org ([65.99.196.166]:51674 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfBLAH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:07:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1C07I2V020437;
        Tue, 12 Feb 2019 00:07:18 GMT
Date:   Tue, 12 Feb 2019 11:07:18 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] LSM: Ignore "security=" when "lsm=" is specified
In-Reply-To: <CAGXu5jLvwLxWWiyM4ThJ=eKzDniy_w2Eaizc-h5tK4x7oCEG2w@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1902121106060.20164@namei.org>
References: <20190211225403.GA7769@beast> <74310e83-a258-e9c0-7d98-8b2cc5ced3a4@schaufler-ca.com> <CAGXu5jLvwLxWWiyM4ThJ=eKzDniy_w2Eaizc-h5tK4x7oCEG2w@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Kees Cook wrote:

> On Mon, Feb 11, 2019 at 3:10 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 2/11/2019 2:54 PM, Kees Cook wrote:
> > > To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> > > used on the command line, and report that it is happening.
> > >
> > > Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  security/security.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/security.c b/security/security.c
> > > index 3147785e20d7..e6153ed54361 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -288,9 +288,13 @@ static void __init ordered_lsm_init(void)
> > >       ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
> > >                               GFP_KERNEL);
> > >
> > > -     if (chosen_lsm_order)
> > > +     if (chosen_lsm_order) {
> > > +             if (chosen_major_lsm) {
> > > +                     pr_info("security= is ignored because of lsm=\n");
> >
> > This is a little awkward. How about "lsm= supersedes security=".
> 
> Fine by me. James? What would you like here?

How about security= is ignored because it is superseded by lsm= ?


-- 
James Morris
<jmorris@namei.org>

