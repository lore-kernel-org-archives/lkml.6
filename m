Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4894NkUnQNB7hYZ7QFe00/4s6i0qify6t+9BSR9AL8s3f9NWv1DsjCiY2AYSpy0A3D7gmdH
ARC-Seal: i=1; a=rsa-sha256; t=1524405724; cv=none;
        d=google.com; s=arc-20160816;
        b=PksAmSccZ8H7ZYpMNWwrMNrvvrWkaHmlQf+qxhGCJAgqME10WqX7/0+Q1a6nsvUdPx
         F2E+i43IvAs4SEZ2I/Z1eynCsVQ9QjxdP78rRZk8TObAf7bymzOjUKTSZNA1osIMa4gZ
         HbZwS9dt9vdH7KIoaX9Ti6v3OPhvo9PLzVOCXFAt2GFA17wKRp1JegeGXTDGOzoX370r
         Sd9sQMK6CiuT6UPNxOa8DVvLBJ+6/egRlml8CBrix0W5zO1U0sLRxullwfjcGVJyC8bh
         UrpDqe08PgVL2KS4gznohJV/tapgSl2t/dpLddflpzI8Q1eLnCGknz7CCA1HCxyW/yUW
         /W5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SvxqD1FThD+ZRGz+dMtCS2OQ19OUuBpYrxAeF4IJ44Q=;
        b=reCxyIjBsO52Gw8dXkV6a76MariHHYrdrrkRiB2TmybmHOuZcxWkB1409WP4smh9q0
         T18qbaz0yMb2g4fLbBI7TjHojuL9abbmLFQvZkQqx3AmFRdFOZ+ybnNuTr9kIQaJgXo2
         gfRVsYtNgKmrSnKV78a9dlc5+MVdGxH9Um/3XyBAU7LC3LRLp6ELsR3t0cfRr9bjsfXF
         rYGAHyyxBnmDgekwLoiTumqv6ViYrRh9BNiEokzbDAbnnNFt0E0bQsHblYu4Q9yo2FHf
         K6QVEJSluohESmMj1YmUHtLt84EZNQ9wqGhdEnnmZ5P/VdNY5qfmCm9uZCY6rBu163Jq
         n0WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 172/196] s390: add support for IBM z14 Model ZR1
Date: Sun, 22 Apr 2018 15:53:12 +0200
Message-Id: <20180422135113.146185113@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455256824125672?=
X-GMAIL-MSGID: =?utf-8?q?1598455256824125672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit 451239eb3d397bd197a79cc3aab943da41ba0905 upstream.

Just add the new machine type number to the two places that matter.

Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/Kconfig                      |    8 ++++----
 arch/s390/kernel/perf_cpum_cf_events.c |    1 +
 arch/s390/kernel/setup.c               |    1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -289,12 +289,12 @@ config MARCH_Z13
 	  older machines.
 
 config MARCH_Z14
-	bool "IBM z14"
+	bool "IBM z14 ZR1 and z14"
 	select HAVE_MARCH_Z14_FEATURES
 	help
-	  Select this to enable optimizations for IBM z14 (3906 series).
-	  The kernel will be slightly faster but will not work on older
-	  machines.
+	  Select this to enable optimizations for IBM z14 ZR1 and z14 (3907
+	  and 3906 series). The kernel will be slightly faster but will not
+	  work on older machines.
 
 endchoice
 
--- a/arch/s390/kernel/perf_cpum_cf_events.c
+++ b/arch/s390/kernel/perf_cpum_cf_events.c
@@ -583,6 +583,7 @@ __init const struct attribute_group **cp
 		model = cpumcf_z13_pmu_event_attr;
 		break;
 	case 0x3906:
+	case 0x3907:
 		model = cpumcf_z14_pmu_event_attr;
 		break;
 	default:
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -819,6 +819,7 @@ static int __init setup_hwcaps(void)
 		strcpy(elf_platform, "z13");
 		break;
 	case 0x3906:
+	case 0x3907:
 		strcpy(elf_platform, "z14");
 		break;
 	}
