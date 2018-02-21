Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227vwLTUbfZP8+JnnqK52OJehF8uvqCWK/mdL6AvW08ToFwjuIXpvRxxIxCVfo/VSqhFYdTz
ARC-Seal: i=1; a=rsa-sha256; t=1519218290; cv=none;
        d=google.com; s=arc-20160816;
        b=Gd/QpPWpYd6J/bo5ycOjUIV2tTG5bnMacnPW3gZ0jUH/DO0UA+yDR1Z/SiyLUIVK7s
         Tsdc6HJE6NexPSRd68K4zsC/7aS1q/ywgfkG8hwbDjUnhPb2WmsqTN4GfktdfLN9AXoB
         3lLetlIEYgy0hquIl45INr5uHd8lhmVfcqc2NR2TcDu/1zgVea+Y/IZuscGcZU0mzlvf
         /MNNPL/yMYTldCC6OeiWRGm/Iw8BAXJC6yCEUHIvZM1a9zOT0K4F8fUg1HNBsrOSNUQX
         fbMRdjozV4tzpsXZVSIdFUFB2h6LKZBkRF55j+DiXncKbIrj3Hi0TNABu8J8zfW7/xe0
         sPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TZna0AA5n9gUfnhaN14tyBx6xppCJxuVoPLyzAS3nfc=;
        b=qWI7QYYhbAlRJG+H9ERe3+IewT7jf90anSZqbHjSjgKhXuR3OuzfhOt1DyfFOAVu28
         VeEHX5YSUAMwFLsJRdpW9j4cdikWChzx2MK+AnmcXwdt5PP3ggmeLoqqjZ9Xf37Kdfw7
         m95f3kv3ajCIzsD7yOtbUvnqHIT5YrW0SHy4YMrZqYX/xgZFnyy2pi8REXBxRH3LPff5
         DRsG8Ra3HLgvJpP9YMcux2RbHrifQmC9QKudc6ttjxipyPHja1x7+5IBG67qc+XdnPIr
         h3YAZ0zPe6UH5YWQGIMncgib2F5SSSb5px/Fxw2lcM2+sAXbM7smHw4eYk5T+z/ODb45
         sCfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 155/167] ARM: dts: exynos: fix RTC interrupt for exynos5410
Date: Wed, 21 Feb 2018 13:49:26 +0100
Message-Id: <20180221124533.318978056@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015353422054787?=
X-GMAIL-MSGID: =?utf-8?q?1593015838257789636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 5628a8ca14149ba4226e3bdce3a04c3b688435ad upstream.

According to the comment added to exynos_dt_pmu_match[] in commit
8b283c025443 ("ARM: exynos4/5: convert pmu wakeup to stacked domains"),
the RTC is not able to wake up the system through the PMU on Exynos5410,
unlike Exynos5420.

However, when the RTC DT node got added, it was a straight copy of
the Exynos5420 node, which now causes a warning from dtc.

This removes the incorrect interrupt-parent, which should get the
interrupt working and avoid the warning.

Fixes: e1e146b1b062 ("ARM: dts: exynos: Add RTC and I2C to Exynos5410")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5410.dtsi |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -333,7 +333,6 @@
 &rtc {
 	clocks = <&clock CLK_RTC>;
 	clock-names = "rtc";
-	interrupt-parent = <&pmu_system_controller>;
 	status = "disabled";
 };
 
