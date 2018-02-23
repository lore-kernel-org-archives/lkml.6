Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224qP0cb2r9YFR2Aolj++7XD3rMFXo3Nw/6DHD7VqlstL+AJpPJRk84azF8FUWVz8CStuH2U
ARC-Seal: i=1; a=rsa-sha256; t=1519411100; cv=none;
        d=google.com; s=arc-20160816;
        b=ojD1doRpJktrrZHbqjOgCYAs9zC1M0KS3OWSG2GrYIQ90YCONbG9YVbNtgpN7HI536
         yGe7wutO52xfpN+SpbNh/jbQOMFUM3jrDzyhUfx2Utn/fXXiJ90n/JMgEO7wvFXC6Wav
         6HD5eMIeGhvngZE+HDnCMMZwMHk382dpZSnLDHHDDligNlsbJcOzGalsthrpo0Osq3ne
         UJcnJNEkmLuEqj1UuuUUbyRoz5SS0hwHt8ZRR3PF0v7MsqCGs7IJdP/d7UZSr10IZL5L
         kH8NLcJXYcVV/4lYO+grMYds1/thB1+D/FYX3mI2ovS8QpsNBpp6Rf7s/mCOjf2SyPWz
         hAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EB+gP8nlJk4qL3w+lmWO0mlj/prkv5tQ6C952srfR8c=;
        b=itm5ogsK7puCus6KjStJMgHKOQp/t4iLvtr0+qpHL69cvF7Rlmxu4Y2KDdcdzKB0N7
         WamamY3dOwvN9a5OdBcC19PYQ62EqM9PCjGmgJdB/m1d++dyw6zQkSB5grhLAcF66FN3
         qUHlShTokDyiXpRoh4tV5OcPenO9kP8RiH639u9A0G+loPenev8gPhtQSywhCRUMIj2n
         ydFSW4A3K4xGKy45d5204c5SK7KbAAt4qD9B6t+XA84Socw1rDXKFcoegx7DJ9oEz3J2
         TUz4hHuZZ1oaU+2fng15zDreg7I3t0UyGT4AwH5KZJ0ncP2ClSyb46zF4k3kIMi0PpgZ
         QyWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 114/193] rtlwifi: fix gcc-6 indentation warning
Date: Fri, 23 Feb 2018 19:25:47 +0100
Message-Id: <20180223170343.775799857@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218013950563813?=
X-GMAIL-MSGID: =?utf-8?q?1593218013950563813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 2acd846485549655582ee379ceb966206f91e6f8 upstream.

The rtl8821ae_dm_txpower_tracking_callback_thermalmeter function
contains a call to RT_TRACE() that is indented in a misleading
way, as pointed out by a gcc-6 warning:

drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c: In function 'rtl8821ae_dm_txpower_tracking_callback_thermalmeter':
drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:2491:4: error: statement is indented as if it were guarded by...
    RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
    ^~~~~~~~
drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:2488:3: note: ...this 'for' clause, but it is not
   for (p = RF90_PATH_A; p < MAX_PATH_NUM_8821A; p++)
   ^~~

It is clear from the context that the call was not meant to be
part of the loop and only the indentation is wrong, so this
removes the extra tabs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -2488,9 +2488,9 @@ void rtl8821ae_dm_txpower_tracking_callb
 		for (p = RF90_PATH_A; p < MAX_PATH_NUM_8821A; p++)
 			rtldm->swing_idx_ofdm_base[p] = rtldm->swing_idx_ofdm[p];
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "pDM_Odm->RFCalibrateInfo.ThermalValue = %d ThermalValue= %d\n",
-				 rtldm->thermalvalue, thermal_value);
+		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			 "pDM_Odm->RFCalibrateInfo.ThermalValue = %d ThermalValue= %d\n",
+			 rtldm->thermalvalue, thermal_value);
 		/*Record last Power Tracking Thermal Value*/
 		rtldm->thermalvalue = thermal_value;
 	}
