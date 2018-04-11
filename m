Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/yZ0fYXbDjFNm91KO6o0q7hsPev2AiMYb7NUG9bThEc+irPdmIl6BLLWyoi4EBAO7ZWRsv
ARC-Seal: i=1; a=rsa-sha256; t=1523472115; cv=none;
        d=google.com; s=arc-20160816;
        b=FTR9Z/NPPJyIUFajnR72nY5+c+FqSYvs3xmgJrCJl6ku5P1yd6hMR5yKKBVqgNTgnB
         PjLzCBW3JEuVxmvanU0Hb62lx6GDVncl2wxnGUmGyoTcYIqWShip0kugdB7kVcPSdt3S
         ltCJ+3x4uJLhu8d8oAa9TzzTjuSSfO/CUZPSNfMbZaD1ByWiwxc6QW6R1W1Dltioa2xm
         p123Pcz0zbH6siJDzhlr7gPlhCjDkFmzhy63H4krvLWF1qJgeZ9Ke7NrdoUyNNo4agM+
         r+Z0nEK64Fd/FjfWwulDfGul5fcQ/NrC1RHsU7+wmEcDWhntHjiw+FRTioeBXzhytvv1
         mDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iaDAJhmcunWo2UMPc5zCxEprVQPKHdNQB45Sm6OFrw8=;
        b=0uGARmhnT3YlgQ1pVFZnr3AzaS3PK8AwnW6QzIc1AzUTJVAKQ+CEEcagmlSwI/dRtY
         bPM/p03qF6oYDs57dRibiX/bKaPHP5f5zK4SjArEe/oOahATmPWYXne3dS5PEB2GHaO0
         ZAxZlzhMsUf80HZobcUxKAZjUJj72688opzZHDalcXvCdx9/ZTv3tDs8huJl6m25eHmH
         JR9tyKBdhJHcvaZtr7ah2qDlgzZ4s6waR9dA2uvhlyKNMETRo7u1EBuUdGnprcjyqVgQ
         Ne7xma6BNIbmIt+beuQMDkJBG3CDr8uSrIrjsxkF/TPAqL/Q9bvpHUm18eR52AqajOWx
         yAWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lorenzo Bianconi <lorenzo.bianconi@st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 085/121] iio: magnetometer: st_magn_spi: fix spi_device_id table
Date: Wed, 11 Apr 2018 20:36:28 +0200
Message-Id: <20180411183501.421370078@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476297255484275?=
X-GMAIL-MSGID: =?utf-8?q?1597476297255484275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>


[ Upstream commit c83761ff0aac954aa368c623bb0f0d1a3214e834 ]

Remove LSM303DLHC, LSM303DLM from st_magn_id_table since LSM303DL series
does not support spi interface

Fixes: 872e79add756 (iio: magn: Add STMicroelectronics magn driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/magnetometer/st_magn_spi.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -49,8 +49,6 @@ static int st_magn_spi_remove(struct spi
 }
 
 static const struct spi_device_id st_magn_id_table[] = {
-	{ LSM303DLHC_MAGN_DEV_NAME },
-	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{},
 };
