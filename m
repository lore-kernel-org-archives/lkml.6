Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/s6p48t3OPUVwgdgUuo442J3gCcp+EzRX9MSuaQTdEuj+59tMDcFiUCf3CmtL5D1nYNtAU
ARC-Seal: i=1; a=rsa-sha256; t=1523473420; cv=none;
        d=google.com; s=arc-20160816;
        b=Kjro95D1L71+p/RLH3serbgkJogQPdMZ0UIWNCSPesnrjGQJl/dIe1t9kGn7cRwJMP
         PxetKYQ+Po5tTXYGgRVuTxyLtr3B+v+I+pQw22m/qMHrnlL09cAP/gEJifC7j7uWvjUB
         O/aFJilOcIwdNb+wz5KpoT3xnpuPEIB1KEPnfhh8rergq3DFlFZBit2tC2MG26N1mpPx
         gMvmZDvKdpBiKQaHWhfxFr4XxbG7D3HVHHLCKMPtdHjcRHPlzCeOo6RHNT7ot7i+EiZG
         etMttZ6PXjRIZBAWgR3pRP9+knncSEI+fNTnyIm2SvzHsXDGTnBm3+jI70HlW3zlowjS
         PRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o5+xDumRYQZ1I/vlebDYaSRbJvE8JSokSj+lBe22ijA=;
        b=yY3KR/Nd5DrJ4KduEANJllivxUYtXw/wMPRJoKwlrQEgs/Q+FY3hI9lozbC+zON+FG
         nX4OihE5NbvLdobq16CFOXyqbUjUe/dNk9vjvf53Xjf6xPZumLrK/cYhs31jYJjCozw5
         FP7CZsVgUADzUCvOS+06T3h2YsT16ZeunywTAyF4k/CFuOBSnW4Yapjf9MC71uzjlXlv
         2ouXxcR/rNELBlgCRYSFI2+U+0xiVrnIsEYca79m9pjUjdrVf63h1Qgxm5yhoR1evHCG
         hreVSrf9ZfHowTMkcXEn6oC0a1qcVi8111ryQ4IEId2EAlhoyoOnwO6rnyhpmexfOUgO
         A9Ww==
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
Subject: [PATCH 4.9 240/310] iio: magnetometer: st_magn_spi: fix spi_device_id table
Date: Wed, 11 Apr 2018 20:36:19 +0200
Message-Id: <20180411183632.809486131@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476297255484275?=
X-GMAIL-MSGID: =?utf-8?q?1597477665087718317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -48,8 +48,6 @@ static int st_magn_spi_remove(struct spi
 }
 
 static const struct spi_device_id st_magn_id_table[] = {
-	{ LSM303DLHC_MAGN_DEV_NAME },
-	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{ LSM303AGR_MAGN_DEV_NAME },
 	{},
