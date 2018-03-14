Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AG47ELukiZVHc4kPOXh7bh664s0CkGnOxuxqEpoSvTvAQVCE9q+F6Isv207uMXWlU9Hz2MG1odtX
ARC-Seal: i=1; a=rsa-sha256; t=1521040541; cv=none;
        d=google.com; s=arc-20160816;
        b=iu2Ed+T4q44GlPCWtJBSlTDRfNFhSN38poQGqDj5FjfbKJGmZ+ewSS8Gtj/+9ghPQI
         OUN2CPlmDFpuWsGX9/vEkrwPyk0iwCl2xVN8r8RfFhvHDK0XOYj7d4gMGis9ljDgmzJ/
         6ya2EVoCppeIS9C9DKt3bcQiZ/9widCCYPup+xQoEzE8Fj8oaue6h755wGvUlBlZtfpt
         pUKpbhhyPxl6oREgzWLF52WLTYdw1YqzebnVK+rSkDu28WEuBAhGdmJrWQKOM9i1uqs2
         /wbaitnsJ28CXymhPfHw3M2nth7fKdyGKRoCxNNKNn2XOWiqiTWDlhJCHgYt6OBV4qVK
         HMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:arc-authentication-results;
        bh=THwNo+J4OcmIF1PBCEOfzk7TonKx38uEkfJyx4Cx7Po=;
        b=tYY0a102+hkIlC+wQ6coXxC4XHiXzBzCF4ID49juNm1gkf+QCw6JaZETQs/QkFSanG
         27jPOD8aAthJYZE9EoFP/wEzIjdSkV2m+1aCAxroS1YvTiif48lw3PW4IelwaAIl7YBh
         jUMNBKU3fq7Z86khN0wdTFzZNuxMlnpMzAEXldr1Z9pqIsZQXpAHjgBe562Ub1JvD7wI
         aBFXAdlbaW3ybNQ28WazFl/dD0a14Y4/+nEyxuZ72ny9w0K40kUbRWxWMD8O6I3Ic3A9
         Ojc0FXoKtKuBZ6rqC/VFvuv5umF7k5vd2II9G8mam9qIV/fr9KRGWXrW5k49YLlnTFr4
         8rZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.3 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.3 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
To: linux-iio@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Pravin Shedge <pravin.shedge4linux@gmail.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/gyro/bmg160_core: Improve unlocking of a mutex in five
 functions
Message-ID: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
Date: Wed, 14 Mar 2018 16:15:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:5LIAtmnAtFMvbpgELhONepqMHFPO8p5Ana8ptHimgqIb9Km9zGG
 a7hddbXKhKZE3FTuOpzdm/8yvUGuxL+F1uwFB58F5NIfIH9udwFWtQPxVYzooZfbwsjvKQw
 FBDqzWzWphUZJ/e3EzQK9e4Sghk5iPl0XCjPmOrAW1hkqiqFoxLI9CfuS/Zfo42XPZIAKaB
 a0eMpiIMhAAQkYyCwnjgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AVFQclTeDTc=:mQ7/4lJ4pLYikrEwJIPOQZ
 FzvDHRJ2h9NP1H9nt9GUS5W+aSlGWJjnkI/O6vw2g2pR7LkgGjs74Bw8CoN6NsVbBpmSzqyeU
 lW8bVENOTjmi5fncZHxQA6wrfvvr//b0nGiHYegb4J1/rNsNVENA9TaBut2VJm8Rbjgi73QyO
 pPeA7+g5mrDhTDRiOFmuzUt+Ikm0nqAcm+00hHzomrzrvLUXvWe1WB53n8Lc6KDJrqHBWfBNi
 g/oCdO046Q7cbqNsBkYZB99rQevCZLN5dup1XgHs0HzEfvOJMotPiDUNsVLzcQslQu9EguurJ
 /FcQmd/6HWs09q5vQi0hPFcmBp6b9ImBvceOeZyv12mwYkNVN3JhJyGeujanv8PZK+y+ZtMkq
 BeFBG/tMMqaUH9bTS7a1Q5uYTAaQyS6E5BM2j2+ejJ4lDOaxBjks0Lrf+V6mL9Rat+xAaVvvY
 +Z2Gxb99F9SdzKFiaI06+v1jynGjoDuDQ6USGXrVljS3zB7G3j1YcE1/oY2qMk5JY8xsE6n6O
 FUMikfOoT5KOul7BU7EO8BKFZ28MuASgoj7DxY2Flp/BecZueG9y1iPoCv7uP0yFLGRGFqY3r
 iiGyKLpH/7oK8iDri/x2pREJiK7LPOveRj2YrmEqP+qW8FYpNcsHg2ksq3FftVY7N5takkmgx
 JLaM7uUgW4GkkrQnIRLSeoEikakH09A9samp7hw2Vatn9in6QyGDFd9sjkq/NrnYn91LTCiqh
 weF7t0N2jwBEiZnuGBEcMlv5o1AUDeGc8vypvhgrXNer65E+ttSy6tpbr/SPGzqcEa0v7xPv7
 NJTW/XWnR3I8SrzENZDR8WYhemhbt85+kQtpVypH8w2MZI1ivQ=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594926606648991207?=
X-GMAIL-MSGID: =?utf-8?q?1594926606648991207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Mar 2018 16:06:49 +0100

* Add jump targets so that a call of the function "mutex_unlock" is stored
  only once in these function implementations.

* Replace 19 calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/gyro/bmg160_core.c | 103 ++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 63ca31628a93..fa367fd7bc8c 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -499,21 +499,19 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 
 	mutex_lock(&data->mutex);
 	ret = bmg160_set_power_state(data, true);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	ret = regmap_read(data->regmap, BMG160_REG_TEMP, &raw_val);
 	if (ret < 0) {
 		dev_err(dev, "Error reading reg_temp\n");
 		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 
 	*val = sign_extend32(raw_val, 7);
 	ret = bmg160_set_power_state(data, false);
+unlock:
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		return ret;
@@ -529,22 +527,20 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 
 	mutex_lock(&data->mutex);
 	ret = bmg160_set_power_state(data, true);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(axis), &raw_val,
 			       sizeof(raw_val));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
 		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 
 	*val = sign_extend32(le16_to_cpu(raw_val), 15);
 	ret = bmg160_set_power_state(data, false);
+unlock:
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		return ret;
@@ -632,19 +628,16 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 		 * mode to power on for other writes.
 		 */
 		ret = bmg160_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
+		if (ret < 0)
+			goto unlock;
+
 		ret = bmg160_set_bw(data, val);
 		if (ret < 0) {
 			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+			goto unlock;
 		}
-		ret = bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+
+		goto set_power_state;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		if (val2)
 			return -EINVAL;
@@ -653,18 +646,15 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 		ret = bmg160_set_power_state(data, true);
 		if (ret < 0) {
 			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+			goto unlock;
 		}
 		ret = bmg160_set_filter(data, val);
 		if (ret < 0) {
 			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+			goto unlock;
 		}
-		ret = bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+
+		goto set_power_state;
 	case IIO_CHAN_INFO_SCALE:
 		if (val)
 			return -EINVAL;
@@ -672,24 +662,27 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&data->mutex);
 		/* Refer to comments above for the suspend mode ops */
 		ret = bmg160_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
+		if (ret < 0)
+			goto unlock;
+
 		ret = bmg160_set_scale(data, val2);
 		if (ret < 0) {
 			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+			goto unlock;
 		}
-		ret = bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+
+		goto set_power_state;
 	default:
 		return -EINVAL;
 	}
 
 	return -EINVAL;
+
+set_power_state:
+	ret = bmg160_set_power_state(data, false);
+unlock:
+	mutex_unlock(&data->mutex);
+	return ret;
 }
 
 static int bmg160_read_event(struct iio_dev *indio_dev,
@@ -763,8 +756,8 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 
 	if (!state && data->motion_trigger_on) {
 		data->ev_enable_state = 0;
-		mutex_unlock(&data->mutex);
-		return 0;
+		ret = 0;
+		goto unlock;
 	}
 	/*
 	 * We will expect the enable and disable to do operation in
@@ -776,22 +769,19 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 	 * is always on so sequence doesn't matter
 	 */
 	ret = bmg160_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	ret =  bmg160_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 
 	data->ev_enable_state = state;
+unlock:
 	mutex_unlock(&data->mutex);
-
-	return 0;
+	return ret;
 }
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100 200 400 1000 2000");
@@ -919,8 +909,8 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	if (!state && data->ev_enable_state && data->motion_trigger_on) {
 		data->motion_trigger_on = false;
-		mutex_unlock(&data->mutex);
-		return 0;
+		ret = 0;
+		goto unlock;
 	}
 
 	/*
@@ -928,27 +918,24 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	 * enable/disable operation order
 	 */
 	ret = bmg160_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
+
 	if (data->motion_trig == trig)
 		ret =  bmg160_setup_any_motion_interrupt(data, state);
 	else
 		ret = bmg160_setup_new_data_interrupt(data, state);
 	if (ret < 0) {
 		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 	if (data->motion_trig == trig)
 		data->motion_trigger_on = state;
 	else
 		data->dready_trigger_on = state;
-
+unlock:
 	mutex_unlock(&data->mutex);
-
-	return 0;
+	return ret;
 }
 
 static const struct iio_trigger_ops bmg160_trigger_ops = {
-- 
2.16.2
