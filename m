Return-Path: <keescook@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519689870; cv=none;
        d=google.com; s=arc-20160816;
        b=ZZJ2fr9cK2vkwj6zMd4yBtumS/wofvUVX4omIhEbopeFZvrseaoXGFdS1Qzx45vwrB
         jKoy7weGKgSt6slskXsJijo77iPzwKpaV/9hDnQhy99UDnw9GRGaxnIazw0UpPKYh4s1
         rzgXKh30WcNmw0T0yFWBTw6HGeSQkKq9lYkX7Bbd4KbPinT9XUp1mEbGhjSUEP1UtSoq
         fc9k7+NtbUS3r0/A4fkuDOu8YQb0lWdI55+J6fTvIMwtiFvAdc64AaSdeAfT77ieLN2n
         VAvx7ZWPUSCRutC4dCeDJcodauyrt02ht6Z04aFrLU847P1kk1Na48pdU4g4Ehp/JWax
         nEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=8R6M4igdn3MuUOZc75o8GisazJr9PyHnmPOVDj1EuZU=;
        b=nQRxHFbVKsgNmBBTQ9UwZdbu7X7kNiqKQWTi8r7bwqmOUoMOG3ej1ZJfUXYtOZxXiN
         sJ/rivCKDdveB3WTl3QfxX6a7BFyPRpJHUvfDC5jr3njD8eXv6aGGgATTJOIKDOh+K6p
         zX4O9LCOUXuRdc46q0Vp3DxMkIsQt6qEAFMRyGN1etGyicQoWoCJq3oVFU1RgLMD2Nr2
         oRgKDPHVuyiOwvUgyPHMHy89yR92uolFoWX9CuBU9rdc1oLR1wxgs1pQhQeQiEome8U2
         1CMf0bg96XUvpX9kKBVeIxJmMSylB3KiVr5yAXpdnBXx2bhdOqqekHuAEd9+aqLcvi08
         i/MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=F9V1DI9a;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=F9V1DI9a;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x226ZfYtwyBlo/a2CW6GTaRP8tPvie/pEvEaPNlt5BG4MnCYmngTcIuTj/Yix36rOjoAK2pcBtw==
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Thomas Winischhofer <thomas@winischhofer.net>,
	linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] console: Expand dummy functions for CFI
Date: Mon, 26 Feb 2018 16:04:17 -0800
Message-Id: <1519689860-7421-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593510325793669190?=
X-GMAIL-MSGID: =?utf-8?q?1593510325793669190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a small series that cleans up struct consw a bit and
prepares it for Control Flow Integrity checking (i.e. Clang's
-fsanitize=cfi).

Thanks!

-Kees
