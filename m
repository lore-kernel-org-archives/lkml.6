Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeBBX3e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:29:34 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:41987 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeBBX31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:29:27 -0500
X-Google-Smtp-Source: AH8x226d4u+b34EKcO3WoVhioVi90Xon/R72xp68el5zKcJWUPGvTYRmesr4UE6EshvB1OYM3JQHIA==
Date: Fri, 2 Feb 2018 15:29:23 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "Andy Gross <andy.gross@linaro.org> , David Brown"
        <david.brown@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: Compilation error report for:
 drivers/firmware/qcom_scm.c:469:47: error: passing argument 3 of
 ?dma_alloc_coherent? from incompatible pointer type
Message-ID: <20180202232923.GK12728@builder>
References: <a2a6bf12-529c-cb20-c69f-106d34e1204a@st.com>
 <e804928d-deb9-668a-7012-2843ba85285e@st.com>
 <CAK8P3a36Kqh-qscU0vsKH00ReXKk8HOYzzhbt6SxAoEBvPYuig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a36Kqh-qscU0vsKH00ReXKk8HOYzzhbt6SxAoEBvPYuig@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30 Jan 05:25 PST 2018, Arnd Bergmann wrote:

> On Tue, Jan 30, 2018 at 11:11 AM, Benjamin GAIGNARD
> <benjamin.gaignard@st.com> wrote:
> >
> > On 01/12/2018 05:11 PM, Arnaud Pouliquen wrote:
> >> Hello Andy,David,
> > + Arnd
> >
> > I have the same issue on drm-misc-next.
> > Does Arnaud's fix make sense or should we update/change the way of how
> > we compile the kernel ?
> 
> We've hit a couple of bugs with qcom drivers confusing physical addresses
> and DMA addresses in the past, usually the drivers were buggy in
> some form, and tried to use dma_alloc_coherent() to get a buffer
> that gets passed into a firmware interface taking a physical address,
> which is of course completely wrong.
> 

Thanks Arnd, for once again using the words "bug" and "completely wrong"
when referring to something that obviously works just fine...


The solution you introduced for venus and adreno relies on static
reservations of system ram, which isn't pretty, but more importantly
isn't viable for the qcom_scm driver.


So, how do I dynamically allocate a chunk of coherent memory?

Preferably with the possibility of unmapping it temporarily from Linux
while passing the buffer into the trusted environment (as any accesses
during the operation might cause access violations).

Regards,
Bjorn
