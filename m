Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeDIIdr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:33:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57806 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeDIIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:33:42 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@google.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>, Alexandru Stan <amstan@google.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [RESEND PATCH v3 0/4] backlight: pwm_bl: support linear interpolation and brightness to human eye
Date: Mon,  9 Apr 2018 10:33:29 +0200
Message-Id: <20180409083333.1249-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This series is a third patchset (resend )integrating the requested
changes.

The first and second patch what tries to solve is the problem of
granularity for high resolution PWMs. The idea is simple interpolate
between 2 brightness values so we can have a high PWM duty cycle (a
16 bits PWM is up to 65535 possible steps) without having to list
out every possible value in the dts. I think that this patch is
required to not break backward compatibility, to be more flexible and
also extend the functionality to be able to use high resolution PWM
with enough steps to have a good UI experience in userspace.

The thirth and fourth patch is a bit more ambicious, the idea is let
decide the driver the brightness-levels required in function of the PWM
resolution. To do this create a brightness-levels table filled with the
CIE 1931 algorithm values to convert brightness to PWM duty cycle.

More detailed info is available in the commit message of every patch.

Both functionalities were tested on a Samsung Chromebook Plus (that has
a 16 bits PWM) and a SL50 device (with a 8 bits PWM)

Waiting for your feedback.

Best regards

Enric Balletbo i Serra (4):
  backlight: pwm_bl: linear interpolation between brightness-levels
  dt-bindings: pwm-backlight: add a num-interpolation-steps property.
  backlight: pwm_bl: compute brightness of LED linearly to human eye.
  dt-bindings: pwm-backlight: move brightness-levels to optional.

 .../bindings/leds/backlight/pwm-backlight.txt      |  34 ++-
 drivers/video/backlight/pwm_bl.c                   | 232 +++++++++++++++++++--
 2 files changed, 246 insertions(+), 20 deletions(-)

-- 
2.16.3
