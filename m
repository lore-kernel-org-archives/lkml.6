Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeCMNvv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:51:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2016 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752775AbeCMNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:51:48 -0400
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Patrice Chotard" <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        "Simon Glass" <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <u-boot@lists.denx.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/10] otm
Date: Tue, 13 Mar 2018 14:50:06 +0100
Message-ID: <1520949014-21468-8-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
References: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/video/orisetech_otm8009a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/orisetech_otm8009a.c b/drivers/video/orisetech_otm8009a.c
index 81b11d7..aa8139a 100644
--- a/drivers/video/orisetech_otm8009a.c
+++ b/drivers/video/orisetech_otm8009a.c
@@ -289,9 +289,11 @@ static int otm8009a_panel_probe(struct udevice *dev)
 	struct otm8009a_panel_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	/* reset panel must be done before probe */
+	/* reset panel */
 	dm_gpio_set_value(&priv->reset, true);
 
+	mdelay(1);
+
 	if (IS_ENABLED(CONFIG_DM_REGULATOR) && priv->reg) {
 		dev_err(dev, "enable regulator '%s'\n", priv->reg->name);
 		ret = regulator_set_enable(priv->reg, true);
-- 
1.9.1
