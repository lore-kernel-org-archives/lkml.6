Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939558AbeE1PIK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033613AbeE1KYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:24:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 217/268] ASoC: topology: create TLV data for dapm widgets
Date: Mon, 28 May 2018 12:03:11 +0200
Message-Id: <20180528100226.854436214@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit bde8b3887add8368ecf0ca71117baf2fd56a6fc9 ]

This patch adds the change required to create the TLV data
for dapm widget kcontrols from topology. This also fixes the following
TLV read error shown in amixer while showing the card control contents.
"amixer: Control hw:1 element TLV read error: No such device or address"

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-topology.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1188,6 +1188,9 @@ static struct snd_kcontrol_new *soc_tplg
 			kfree(sm);
 			continue;
 		}
+
+		/* create any TLV data */
+		soc_tplg_create_tlv(tplg, &kc[i], &mc->hdr);
 	}
 	return kc;
 
