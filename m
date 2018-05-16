Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526489646; cv=none;
        d=google.com; s=arc-20160816;
        b=U3iC3gmu5tp01LzCPg4An2elQcqK69cTxldVfxREXHyAF42OsuFDzGyecpSnd+S0Ye
         IneZnUdAVy0lQKvBim4gQVPQWRgEMWcEjrW9XHZTlKQjad3CK4sxDpnxHHOZ0MJ/jfZP
         P0f65e5x8X2k9PFJyeDtVgBVI4N49IZwCa/zhq2bQdiyx4+dDBl4wZ6wLzVFbaM6zwXq
         BSiGC1Uvk9+XPNevWKRMbCjxWW7Id5TW4WpDNgfkxC1qR+ZMcnukkOeGMf42h5gaZR5I
         qpUJ6wIypywtiyTtqleLrzoMA/e7usMDGowNNKYFiHedsa+MqOTT9fkxtUKI8IApae8P
         WMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bbd7pRpbCv3kBoKpSA3J2EXTFT4MZER+aHIzo6dFXYg=;
        b=Gt6Vt7ZyhIzdx9gQTLHRg0ecWxV0GUINNgKWgJoSndNmlKIxhv1vSBd3LOuH5Sx6bj
         gnTHiBqqSVpzQ4wKXUkHse7hQV5tkcQXsRAaGbSIegV41pl89Jc8OyfcxxLYX3u64LAp
         kV/jZLeq7AZKtti0D26iGzh+qn59NwzR3JoyQCJgF2SXaCauFyZrG0vRP8crIRTOkSEU
         d8vGOONb5VanVExaHdnf7T/3G9/avzrvANDYAvb5wYNh+gp5XhE60CCBZbbcHMc4WC3F
         aScGtYMiwqxhzv3oUJf3l0NN93/k9HMDoamWrDD+v/uzGjXk/UZFblKTV62NNtfSMD9W
         Sn4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hNGMB0A6;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hNGMB0A6;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpW9+8E79O54AUyQD2KfzwNehpqUGUeWMJp3ufdmJAnw4V3QglUXthFUThB5yr7NGveINq0pw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org
Cc: kramasub@codeaurora.org,
	sdharia@quicinc.com,
	girishm@quicinc.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	bgoswami@codeaurora.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: Add QCOM SLIMBus NGD driver
Date: Wed, 16 May 2018 17:51:16 +0100
Message-Id: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640407051991291?=
X-GMAIL-MSGID: =?utf-8?q?1600640407051991291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset adds support to basic version of Qualcomm NGD SLIMBus
controller driver found SoCs from B family.

This controller is light-weight SLIMBus controller driver responsible for
communicating with slave HW directly over the bus using messaging
interface, and communicating with master component residing on ADSP
for bandwidth and data-channel management.

Tested this patchset on DB820c with WCD9335 codec.
I have pushed my working branch to [1] incase someone want to try.
 

Thanks,
srini

[1] https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd

Srinivas Kandagatla (2):
  slimbus: ngd: dt-bindings: Add slim ngd dt bindings
  slimbus: ngd: Add qcom SLIMBus NGD driver

 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        |   70 ++
 drivers/slimbus/Kconfig                            |   10 +
 drivers/slimbus/Makefile                           |    3 +
 drivers/slimbus/qcom-ngd-ctrl.c                    | 1298 ++++++++++++++++++++
 drivers/slimbus/slimbus.h                          |    8 +
 5 files changed, 1389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 create mode 100644 drivers/slimbus/qcom-ngd-ctrl.c

-- 
2.16.2
