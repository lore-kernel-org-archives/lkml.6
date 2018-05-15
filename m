Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeEOHgQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:36:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52022 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbeEOHgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:36:15 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Philippe CORNU <philippe.cornu@st.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: sii902x: add optional power supplies
Date: Tue, 15 May 2018 10:36:30 +0300
Message-ID: <2814752.ZM2IG9T3fV@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <8ed2cfcd-df26-fa9c-c45d-7bf4020f0faa@st.com>
References: <20180425075314.19137-1-philippe.cornu@st.com> <69a9da79-63df-6d0a-52e3-729ec8937484@samsung.com> <8ed2cfcd-df26-fa9c-c45d-7bf4020f0faa@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Monday, 14 May 2018 21:58:48 EEST Philippe CORNU wrote:
> On 05/14/2018 12:33 PM, Andrzej Hajda wrote:
> > On 14.05.2018 11:38, Philippe CORNU wrote:
> >> On 04/25/2018 09:53 AM, Philippe Cornu wrote:
> >>> Add the optional power supplies using the description found in
> >>> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
> >>>
> >>> The sii902x input IOs are not "io safe" so it is important to
> >>> enable/disable voltage regulators during probe/remove phases to
> >>> avoid damages.
> > 
> > What exactly does it mean? Ie I understand that the chip has some
> > limitations, but why enabling/disabling regulators in probe/remove
> > should solve it?
> 
> thank you for your comment.
> 
> And sorry for the "bad" explanation in the 2nd paragraph about the fact 
> that inputs are not "io safe". I added this 2nd paragraph in v2 
> following a good comment from Laurent on adding the management of the 
> regulators outside the probe/remove for a better power consumption 
> management (enable/disable regulators only when the ic is used for 
> displaying something for instance...). But after a deeper analysis, I 
> realized that the only way to improve the power consumption is to 
> implement & test the sii902x various sleep modes, that is out-of-scope 
> of this small patch and also out-of-scope of my test board I use on 
> which the sii902x bridge ic power consumption is very low compare to the 
> rest of the system...
> 
> I will remove this "explanation" in v3 as it creates confusion.

I'd rather keep it and expand it explain why enabling/disabling regulators at 
probe/remove solves the problem. Your patch otherwise looks OK (although if 
you submit a v3 anyway you could also rename err_disable_regulator to 
err_disable_regulators).

> >>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> >>> ---
> >>> 
> >>> drivers/gpu/drm/bridge/sii902x.c | 38 ++++++++++++++++++++++++++++++----
> >>> 1 file changed, 34 insertions(+), 4 deletions(-)

-- 
Regards,

Laurent Pinchart
