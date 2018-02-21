Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226zdOD1a03CaRG8fGvtpOZRBdjCd1pX8+auMWBehDFk8/TAbS1fjyy3NKRVUEQoBAt1mu9W
ARC-Seal: i=1; a=rsa-sha256; t=1519217828; cv=none;
        d=google.com; s=arc-20160816;
        b=yQg5/7D40b19VYuFK0zXWDTnyr37ANGtxDu08ZaM+PGZ+B2xJQsmBaW+R2iwoddZA3
         fLTBVFY/N6ntNH/oelYs7EhpA4tiavDcQFogHXCKNdpvr/J3skMzZ/XkQSqa6Mk4h8+1
         5uRRnYx37x45BnwmPF92b7kZWUP7kh3rsmqdN0BrGM+N80gFCdHT4SIgGvfVnZnO+NXn
         wQGkeBP0MHmU8+8UwaBiAxTf/TLZuPUcrQ6RbaOijG/ML/3ilFuAlrXanFIrrbRaeW0S
         wDYUCRbaE8y4+rdal1PfSS9VFh/2lfeKfzckexcxpYUjb4E6hv6139v6aoPE1o6JD4i1
         QIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gscx9u93jloXli8iN//V48hnO6sXLmR5EnfKXAXSrU8=;
        b=C8bW0MorFd9omMRcKUXoa8bORD2t94+2R3tFyoItNKH/TMTiHb7dOotKIQpuDM2bYC
         9us6QxA59EgDbEZRUrBJ6TIrxT5xq/UP9CesivNbbn6BfsaJ+h3fRDazgHcJxXwU955u
         /7i2/PI8Mz1/jyr2Az6UPHrfbpovO6QBgGDWNpkx9C3zK/yHBT9OTd5HUZI+j8g9maRK
         VAz+PDHh1VWQxNZjpGeDSsclsfw6rTUuk8sqMLoGUihIgidJ0Xn15Q9GoZVE3cYy2TdP
         uq6yBOY1nu2EiCMqbk2Ixn6UFiV7InCFaA9oc9z+J/RsczS5GUTeYsVlHbWhz+TUY5so
         M/YQ==
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
Subject: [PATCH 4.9 69/77] ARM: dts: exynos: fix RTC interrupt for exynos5410
Date: Wed, 21 Feb 2018 13:49:18 +0100
Message-Id: <20180221124435.106795746@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015353422054787?=
X-GMAIL-MSGID: =?utf-8?q?1593015353422054787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -274,7 +274,6 @@
 &rtc {
 	clocks = <&clock CLK_RTC>;
 	clock-names = "rtc";
-	interrupt-parent = <&pmu_system_controller>;
 	status = "disabled";
 };
 
