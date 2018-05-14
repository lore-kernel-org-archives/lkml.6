Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeENRqz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:46:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45384 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeENRqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:46:53 -0400
X-Google-Smtp-Source: AB8JxZqvRLBEQIJfM5PQzWsw1N1yPaz8FZAVyXSSfWONclzsYaScxLP8HgXezJ8ehkqNZpFwYDxLiA==
Date: Mon, 14 May 2018 10:46:49 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom: tsens: Allow number of sensors to come
 from DT
Message-ID: <20180514174649.GM14924@minitux>
References: <20180507235339.8836-1-bjorn.andersson@linaro.org>
 <CAHLCerN9zQEJK4WoV6BY6hga2BxwzMsyScWnTdYcLgEk0Bjg4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerN9zQEJK4WoV6BY6hga2BxwzMsyScWnTdYcLgEk0Bjg4w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 May 07:45 PDT 2018, Amit Kucheria wrote:

> On Tue, May 8, 2018 at 2:53 AM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > For platforms that has multiple copies of the TSENS hardware block it's
> > necessary to be able to specify the number of sensors per block in DeviceTree.
> 
> I assume you want to replace the hardcoded num_sensors values in the
> tsens-xxxx.c files with values in device tree atleast on platforms
> that use devicetree?
> 

Right, e.g. in msm8998 we have two blocks with 12 and 8 sensors
respectively. With the patch we will overwrite the num_sensors with a
value from DT, iff specified.

As probe will fail if num_sensors is 0 we can reuse ops_8996 and just
not provide num_sensors for 8998, hence requiring it to be specified in
DT.


PS. Looking at the register spec 8996 too seems to have two tsens
blocks, so in order to access sensors off the second bank this patch
would be needed (and would work and be backwards compatible).

Regards,
Bjorn
