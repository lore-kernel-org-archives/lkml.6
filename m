Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrdpL9IELcvNkGrrE5rv4Mpz5y8hjQq1HYs0qYCu4MF2gUldR33beVSwYSef0Kme855Cb2v
ARC-Seal: i=1; a=rsa-sha256; t=1527156381; cv=none;
        d=google.com; s=arc-20160816;
        b=dpU8sA87kiD0Q5sSBIeDSqDdfEc9fG0AHTzNwAvhpnvc4TUGvgdA95NCA0RFRRNb/Y
         KGiWlI3SXSyMSsZ8i4rWVvJQDX9FFsyZmUndDs46sXizFuVCDOg3NAth/69dF1rIT42w
         dLjxIgBg4c1aXwxgvoEnz5Lm++ZK3E5JGDdW86smKGHtknpLT0dRL0OPCCxGMpK1/xS4
         jSz8+ip0DQe9clhXrgab21fnY0oyJTdQ2wr8DvlAsMWBWsBz0Zrj8RzBfeRYphcjL7PH
         BLvU3m6wmIIDIz95nyqgVWGJhWlhngim+ofk7klnD2VM9+gmewJ3/fHryDGpdPe0Txb4
         VSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=48Bf8V9klqlwaOV3tEQtSyHQoPjQRXmBFfhqWSHNZF0=;
        b=mwutLfW7/pvRqcm+RGq71tIX8X0t5AAOreu8Rn4JMOPTU9Q4VaI6PZ8KSi5mgvnZWg
         jJOGxk4NKgKb+CVzjTHRCRsDtqLZpOxa2KYUHgRy95ZVw9dOEeQ5N/qtA0pKC0cXiQA/
         Zbk+HJzzoyH1XTY3jzoc01lLqo2IXWyxeQFu9exuEHDN03OvJr2rb8EwH7j3sCE5rvmT
         xZPB/vZNfBoFH3Q0oRMBlmDz2QUBu9Z/mC/bpLovnouu4O7uUiUN617a+QvZWgW0a8v6
         6wnBi6DZMSZkb2nx17olw/29rXY/s/frYb08FjMaKPNV+G5q5X5XcyNT79e8+rIE2yX6
         LghQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=B2nPsXig;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=B2nPsXig;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 141/161] media: i2c: adv748x: fix HDMI field heights
Date: Thu, 24 May 2018 11:39:26 +0200
Message-Id: <20180524093035.238130761@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338995847294247?=
X-GMAIL-MSGID: =?utf-8?q?1601339529724557482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

[ Upstream commit 9f564184e6cc21a86c26bab920afac1bab7653ff ]

The ADV748x handles interlaced media using V4L2_FIELD_ALTERNATE field
types.  The correct specification for the height on the mbus is the
image height, in this instance, the field height.

The AFE component already correctly adjusts the height on the mbus, but
the HDMI component got left behind.

Adjust the mbus height to correctly describe the image height of the
fields when processing interlaced video for HDMI pipelines.

Fixes: 3e89586a64df ("media: i2c: adv748x: add adv748x driver")

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/adv748x/adv748x-hdmi.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -105,6 +105,9 @@ static void adv748x_hdmi_fill_format(str
 
 	fmt->width = hdmi->timings.bt.width;
 	fmt->height = hdmi->timings.bt.height;
+
+	if (fmt->field == V4L2_FIELD_ALTERNATE)
+		fmt->height /= 2;
 }
 
 static void adv748x_fill_optional_dv_timings(struct v4l2_dv_timings *timings)
