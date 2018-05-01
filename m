Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756160AbeEAQTc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:19:32 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39711 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755316AbeEAQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:19:30 -0400
X-Google-Smtp-Source: AB8JxZqQ+O0YTUvVjsxmwPLHXNBp4Xe/k0VsanZ5k/52Mp5NpYv/uy+44loo0IVHYUO2B/y401mBMg==
Date: Tue, 1 May 2018 11:11:25 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver
 documentation
Message-ID: <20180501161125.GA14380@rob-hp-laptop>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com>
 <20180429055417.GA10221@mithrandir>
 <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com>
 <60772240-3c75-7814-9237-d60916a8ceca@suse.de>
 <CAMgXwThYN1E=awkd8yF2aNN+QOLwHkx=UyWqGrOnMxv5jyVj5g@mail.gmail.com>
 <20180430081946.GH2484@ulmo>
 <61f24d16-5095-76e4-845e-2434029fe1f0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61f24d16-5095-76e4-845e-2434029fe1f0@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 12:45:20PM +0200, Andreas Färber wrote:
> Am 30.04.2018 um 10:19 schrieb Thierry Reding:
> > On Sun, Apr 29, 2018 at 02:08:07PM -0700, Wesley Terpstra wrote:
> >> On Sun, Apr 29, 2018 at 2:01 PM, Andreas Färber <afaerber@suse.de> wrote:
> >>> "pwm0" sounds like a zero-indexed instance of some pwm block. If 0 is
> >>> the version here, I'd suggest to make it "pwm-0" for example - you might
> >>> want to take a look at the Xilinx bindings, which use a strict x.yy suffix.
> >>
> >> That's fine. I'll change it to pwm-0.00 in the next patch series.
> > 
> > This should match the version that you use. If you're internal
> > versioning uses single digits, or a single version number, then I think
> > there's no need to use 0.00, because that would just be confusing.
> > However I think it'd be good to make sure it is discernible as a version
> > number. Perhaps something like sifive,pwm-v0. That seems to be a fairly
> > common scheme.
> 
> Yes. My point was not to adopt another vendor's versioning scheme but to
> adopt _some_ consistent scheme and document it, e.g., in a sifive.txt
> similar to xilinx.txt:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/xilinx.txt
> 
> It should be made clear what in the compatible string the version is
> (thus my proposal of using a dash as separator), and there you may want
> to document how to map between IP/documentation and compatibles for any
> new bindings.

Yes. And using versions in compatible strings is only accepted when 
there is a well defined versioning process. FPGAs tend to be the main 
case as most SoC vendors don't have rigorous versioning processes. I 
guess it makes sense for SiFive from the little I know about them. What 
doesn't make sense or get accepted is software folks just making up v1, 
v2, v3, etc.

Rob
