Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934540AbeEYNVE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:21:04 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46482 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeEYNVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:21:02 -0400
X-Google-Smtp-Source: AB8JxZpI/ZpfLABnN0E5acl91g0VuMZB2ZKRSCLhqo22/K4l7dlP22F9Cvr+7nHzbkTslI1eKf3b9RJoNFIC/cEQxIg=
MIME-Version: 1.0
References: <20180522165842.233949-1-groeck@google.com> <s5hmuwqpjdd.wl-tiwai@suse.de>
 <20180523135609.GK4828@sirena.org.uk> <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
 <20180523155811.GO4828@sirena.org.uk> <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
 <20180524141842.GW4828@sirena.org.uk> <CABXOdTfKXqgRecs3xuxb-XRodJkK7+h5V0hqt889CsD6vkm5yA@mail.gmail.com>
 <20180524151137.GY4828@sirena.org.uk> <F46914AEC2663F4A9BB62374E5EEF8F88276C0ED@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F88276C0ED@SHSMSX103.ccr.corp.intel.com>
From: Guenter Roeck <groeck@google.com>
Date: Fri, 25 May 2018 06:20:50 -0700
Message-ID: <CABXOdTfZN2jqJfvzZFLESqfb4Vy8VF3H9TKin9o8k=0=2p297g@mail.gmail.com>
Subject: Re: [alsa-devel] [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
To: mengdong.lin@intel.com
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>, shreyas.nc@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 2:04 AM Lin, Mengdong <mengdong.lin@intel.com>
wrote:

> > -----Original Message-----
> > From: alsa-devel-bounces@alsa-project.org [mailto:
alsa-devel-bounces@alsa-
> > project.org] On Behalf Of Mark Brown
> > Sent: Thursday, May 24, 2018 11:12 PM

> > On Thu, May 24, 2018 at 07:55:06AM -0700, Guenter Roeck wrote:
> > > On Thu, May 24, 2018 at 7:18 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > Your mail client formatting seems to be broken, the word wrapping is
really
> > funky (it looks like it's breaking longer than 80 column lines in the
middle of
> > paragraphs rather than flowing paragraphs within 80 columns).
> >

gmail. Teaches me to not send any patches from my corporate acccount;
it is all but impossible to teach gmail to leave formatting alone.

> Please put the Skylake specific structures in a separate header file, not
in asoc.h.

> The file asoc.h is for generic topology structures which are platform
independent. The topology code in alsa-lib never parses the platform
specific structures.

> The Skylake specific structures are needed by vendor applications like
Intel topology tool (ITT) to define topology for different platforms. The
applications can include both asoc.h, skl-tplg-interface.h and other device
specific headers.

https://patchwork.kernel.org/patch/10425395/
https://patchwork.kernel.org/patch/10425393/
https://patchwork.kernel.org/patch/10425387/

should hopefully be along that line.

Thanks,
Guenter
