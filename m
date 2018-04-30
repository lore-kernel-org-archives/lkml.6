Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754544AbeD3PKT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:10:19 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33402 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754474AbeD3PKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:10:16 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 30 Apr 2018 16:10:04 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH RFC] ASoC: dai playback_active and
 capture_active may be greater than 1
Message-ID: <20180430151004.edal7xei4okf7hao@localhost.localdomain>
References: <20180419140612.11049-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180419140612.11049-1-jbrunet@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=279 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804300145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:06:12PM +0200, Jerome Brunet wrote:
> At the moment playback_active and capture_active are using only 1 bit so
> the maximum active count is 1.
> 
> However, snd_soc_runtime_activate() may be called several time on the
> same dai. This happens when a dai is part of several dai_links. It is
> often the case for "snd-soc-dummy-dai".
> 
> This is a problem if snd_soc_runtime_activate() is called an even number
> of times on a dai. In this case the active count overflow back to 0. As
> consequence, ASoC functions, such as soc_dpcm_runtime_update(), won't run
> correctly.
> 
> Storing these usage counts on plain 'unsigned int' solves the problem.
> 
> Fixes: f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
