Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4++2/882xn2BePjMypZfXs5QX3HPw6IfjytBh/qa71ZhoPwBNLxASXaedb94vyroHlzTbjl
ARC-Seal: i=1; a=rsa-sha256; t=1523472695; cv=none;
        d=google.com; s=arc-20160816;
        b=ieM7ne/UQpU2g+3fT9fCJrEu8+2JN5GSx4xmg5D1vITDiICV/S6oMESLpw0nMQhJ30
         4IMbva32bzQqKDxV9QKy/3+nFYsfhhv7rEuZTvNYoKBG5AGyhaE96nysALLD14sE5DI9
         NkUKtWjDMFH+00VT2i4YF0GM4qYiuHuOzvU/Q/0oIL6dVnhO4vEmejavkgHEgaoelBUN
         SlQPi+lm1i/dUcKFnKvv1eiOcjyaFDjzBuovtKtoRbI5mbTrJxHX0cCUNzB68731NIOn
         yoqxMPo4zPTcNSFAyeYYKvTc1+/AIqFyuOhYv5scrynjEO+rGQUYLKOK2r5kxnKadIRu
         W05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DKh+pCxFAoW7Tc2DYa5EyyL8+xlVsdLZ47dE3kQW1ls=;
        b=A33sSd09Dx6u9BQV5mFCJ95QVJlDMuMZzAkc46jTdsTHiZYNWpSK03G2t8xaYBFqb2
         tfD7BHA7AONHc4zvbMYNYjQ8kSp++Urcuna44WGpDmOktsV9x+mDxvMWyzHWxjYiTpXm
         WqrQ4T08xRPFnH7HIn/CuNphfnMD6nq8VD3kilOat96LPT19sbMZMWzaO9YEtR185gvC
         P5NZljZzZ65F4/7uaTnp7H5UlVpJMiugs6vr/KIhEnlmCEuej6DTu2Jxo1pysLDudrSW
         RH3CS6fK0bOvSkeM6IyR97qLfLFj7Pc4d0/S8JZVLc60kMtNPaqx97MjOBjA4/jgmI6r
         41Pw==
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
Subject: [PATCH 4.4 142/190] iio: magnetometer: st_magn_spi: fix spi_device_id table
Date: Wed, 11 Apr 2018 20:36:28 +0200
Message-Id: <20180411183600.927391137@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476297255484275?=
X-GMAIL-MSGID: =?utf-8?q?1597476905350718894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
