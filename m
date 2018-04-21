Return-Path: <rodrigosiqueiramelo@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524311693; cv=none;
        d=google.com; s=arc-20160816;
        b=aa1eH5X2wMe2ux+NSTZwu+d7a5Rfy+nYkqzUhtUZgeXL1Ojc2BQt/+oLv1Vi17M6JD
         5qgcs9kjU1H4cvk3OcrF06xzDSCRQMmQkhdL9Pw3LSyWwjP/Vgf3sPgnUyG6BasUvqJR
         eHRWtzo4OUmKt4C57+ru2B83O5ec4w9+Kxu3GoOqlIenEGco7wyjYJz6e4mKYoWx0Awe
         iXZlr16Yzg85qXHd+qmgd6jmnu7/GqC9bsj5bxm0y3TGmiVGYvESjUHhea15CGhx7YPE
         bRgcVDWpczx2M/NP3+aGQT/SYhAamPg0Fi9icUmAn4UbGLrzClE6oj7Djox4rsw1t/VS
         0ruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=FCWHxCRtpIwZEE+7FeNc7Mph2/KbCjGMhWMpdLlkZ0U=;
        b=wMdp3N7m8vXIzQw9e9/XbJlAE4+PQ8q8CaQ6Q2Y6rtLC9i8dwmoQ+0jULeOtJns4No
         UHM8sR2xlopPcn4sqobEuokMhxGewcIkLP7CuOou040JFFDa3K0KMmsbf0kSs9/W6VIA
         SEA30Q7dXr7xOEqMGCBYB29stAA8UpQNlSU/qCMifWZzoqOdlqcgAxj/jeTWUQYs27rp
         bPzORZSRz96lTxDiaOG4D+iY53h7kmB/hO4gdJFVCrUZTDeEtPobmSw05t8gGuE6kPMs
         nZQqIqXl/L7CVxWMOMZYcB6HGekA7Wzc+vBx86SBDv4YiQPVc//iLHaSSrnuRXImYt79
         J6zA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hYmtzf1b;
       spf=pass (google.com: domain of rodrigosiqueiramelo@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rodrigosiqueiramelo@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hYmtzf1b;
       spf=pass (google.com: domain of rodrigosiqueiramelo@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rodrigosiqueiramelo@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+I7JzDhmRX+Dj/I6iscz4zENJduf5vRjU3LXyWAAlYyp4LzOZeDINwBeCRqfq/ZL3eVdeQLw==
Date: Sat, 21 Apr 2018 08:54:45 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Syne <john3909@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] stagging:iio:meter: Add essential IIO API structures for
 ADE7854
Message-ID: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598356657907168522?=
X-GMAIL-MSGID: =?utf-8?q?1598356657907168522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset aims to update ADE7854 by adding the required IIO API
components. The first patch adds the iio_chan_spec for handling seven
different registers (all of them with a similar behavior). The second
patch appends the read_raw function defined by the IIO API. Finally, the
third patch adds the write_raw function and remove the attributes used
for handling the seven registers. This patchset has the contribution of
John Syne, which was responsible for mapping the correct ABI name per
element in the ADE7854; additionally, John provided codes that helped to
shape these patches.

Rodrigo Siqueira (3):
  stagging:iio:meter: Add iio_chan_spec
  stagging:iio:meter: Add ade7854_read_raw function
  stagging:iio:meter: Add ade7854_write_raw function

 drivers/staging/iio/meter/ade7854.c | 129 ++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 35 deletions(-)

-- 
2.17.0
