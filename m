Return-Path: <oneukum@suse.com>
X-Google-Smtp-Source: AIpwx48mg/IZ4QYr//GiBIn/4JRa9WpAyqqzy6qfgiB9ArxZV+Gn1v1se9iUfKqop4ISQC8DXzut
ARC-Seal: i=1; a=rsa-sha256; t=1522830696; cv=none;
        d=google.com; s=arc-20160816;
        b=uowX1sczFO25mpPgWbQEmp+7rF6UH1iAP1046Vo4QgeIcG+lS97VNiKWS7ODhBV+Vy
         X0Gbby2MD3LvNZ9XbcxfSauOAYOs40Q9NwxV+wbRGTMLmUel3ZHI1/0fToJ8IasfdeMZ
         ssd5ElWA+yxNwGtiZCsOftivu8sVHlaVO9c13/+4lj/p2gbOPPL6ijA6LzXg0pm1b10S
         C5xkI4xPCc0nPWddX0YMlnvdkzDmoAwwLqZ+PJ/TnsGayBA4vn0kIyOPpe6ZXGp8mhwz
         Ky+KcsVr2m5phGDQXYTd7NeKMC85sKml8/FNnbXnej3BBiNjv3rvU6Fl6+7V0qk4uJDP
         l6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=tu/5a2I3SgdbZdk0jB+aSSkRwWX7c5uA5YIdib1RpTc=;
        b=RFmzKHGlSDvr5XyXw9W6k6ran6UB0zCO4mWN6rzSibRkD3oeMry2nGpdYCNKl/fTiG
         wIQl7HhYeJicFF2bc14DQsj55AV809YwT5PIp5LgduN5PS1e9u/zsD1NdxDT/wFpx+nt
         CiHK0wMeTYhF300dvDhYDOZTMb5vxqdT5v3W4+kQMekQDg2VmLKwYX7wMSzpdooFh0t0
         bWLdZFVQEkK8Qbd1Tg6emCNni4hsMKLsyqeF4SHsXKsUJqDVnBJIyXXe0d072Zez6EHl
         csXZLaJgquEFM6FrCltpVqDoAMSZNa4q/5wiTaz9u2ZXd5itUR6mIXaDULMSdzceqjdQ
         gNCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Message-ID: <1522830330.30374.3.camel@suse.com>
Subject: Re: [PATCH] usbip: vhc_hcd: prevent module being removed while
 device are attached
From: Oliver Neukum <oneukum@suse.com>
To: Shuah Khan <shuahkh@osg.samsung.com>, Greg KH
 <gregkh@linuxfoundation.org>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org,  linux-usb@vger.kernel.org
Date: Wed, 04 Apr 2018 10:25:30 +0200
In-Reply-To: <6022b8f0-821a-2d1c-8032-4b298835feae@osg.samsung.com>
References: <20180402205232.21659-1-shuahkh@osg.samsung.com>
	 <20180403065618.GA1093@kroah.com>
	 <6022b8f0-821a-2d1c-8032-4b298835feae@osg.samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596669167168287135?=
X-GMAIL-MSGID: =?utf-8?q?1596803720246664305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, den 03.04.2018, 09:56 -0600 schrieb Shuah Khan:
> This is a virtual device associated to a real physical device on a different
> system. My concern is that if the module gets removed accidentally then it
> could disrupt access to the remote device. The remote nature of the device
> with several players involved makes this scenario a bit more complex than

Hi,

you would doubtlessly lose connection to that device. Yet you would
also lose connections if you down your network. You need to be root
to unload a module. You could overwrite your root filesystems or flash
your firmware. In general we cannot and don't try to protect root
from such accidents.

	Regards
		Oliver
