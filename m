Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B616C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B4920B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfBFLqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:46:30 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:55560 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727080AbfBFLq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:46:28 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16BdHuG023808;
        Wed, 6 Feb 2019 05:45:48 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2qfp5p8sut-1;
        Wed, 06 Feb 2019 05:45:48 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 899E8611C8B2;
        Wed,  6 Feb 2019 05:45:47 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 11:45:47 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x16BjjKE024165; Wed,
 6 Feb 2019 11:45:45 GMT
Date:   Wed, 6 Feb 2019 11:45:45 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] ASoC: dapm: Check for NULL widget in
 dapm_update_dai_unlocked
Message-ID: <20190206114545.GR3837@imbe.wolfsonmicro.main>
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
 <20190205211622.GA5891@kozik-lap>
 <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
 <20190206100549.GO3837@imbe.wolfsonmicro.main>
 <CAJKOXPejBO_9iBHg1R8M2=tcuTck72DjxTYEUyQOp8cPV-0xTg@mail.gmail.com>
 <20190206105955.GP3837@imbe.wolfsonmicro.main>
 <CAJKOXPcQfsNnuns1BprEPy4=ggW7fU+_-O_VksrWuT4GPPgAwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJKOXPcQfsNnuns1BprEPy4=ggW7fU+_-O_VksrWuT4GPPgAwg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902060093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:14:56PM +0100, Krzysztof Kozlowski wrote:
> On Wed, 6 Feb 2019 at 12:00, Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > On Wed, Feb 06, 2019 at 11:22:33AM +0100, Krzysztof Kozlowski wrote:
> > > On Wed, 6 Feb 2019 at 11:05, Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > >
> > > > DAIs linked to the dummy will not have an associated playback/capture
> > > > widget, so we need to skip the update in that case.
> > > >
> > > > Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
> > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > ---
> > > >
> > > > Ok so that all makes sense, this patch is probably the best fix?
> > > >
> > > > Thanks,
> > > > Charles
> > >
> > > For this particular issue (NULL-pointer):
> > > Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > However now I see bug sleeping in atomic context:
> > >
> > > [   64.000828] BUG: sleeping function called from invalid context at
> > > ../kernel/locking/mutex.c:908
> >
> > Does this probably definitely get fixed by reverting my patch?
> > It's just a bit odd as this seems to be complaining about a clock
> > operation in i2s_trigger and I don't think my patch should have
> > any affect on the trigger callback. It should get run from either
> > the dai_link DAPM event or hw_params, neither of which should
> > happen in an atomic context.
> 
> Before this fixup, probably NULL pointer happened before any of this.
> I tried it now few times and the possible deadlock and sleeping in
> invalid context did not appear. It might be random/racy or totally
> unrelated to your change.
> 

Looking through I think this is an unrelated issue. Assuming the
driver in question is (sound/soc/samsung/i2s.c). Inside
i2s_trigger, there is a call to config_setup(i2s), which in turn
will call clk_get_rate if i2s->quirks contains the flag
QUIRK_NO_MUXPSR.

The trigger callback can be made from an atomic context and
clk_get_rate will take the prepare lock of the clock. The clock
prepare lock is always a mutex which shouldn't be locked from an
atomic context. So it seems like this will fail whenever that
QUIRK_NO_MUXPSR flag is set, no idea what causes that to be set.

It looks like this bug was introduced by this change:

647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")

Thanks,
Charles
