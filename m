Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x225mhM/4r/lBlpQctZD86CKhkWnEt2Uwbfp53Fhgmcce0jAy9WTQv+DFyolcdnFKMHcESfx0
ARC-Seal: i=1; a=rsa-sha256; t=1518817338; cv=none;
        d=google.com; s=arc-20160816;
        b=lMb35ozTPMRkNRu0sHL8oBzguSVor3gniqJH1vrpzFW6794Ys+AtOilB7eVg27zwVu
         1JXS/myxJeh8kTkBev7538gzzfmzRn92DxpIseU3Ix1TyZTIjT6PuimW2bIHHEKURAPV
         +mkVXCvv9AgiI6rhN1MKK6OUjVH0zwgR65nv4gpWBDHi1XbgPO3xHTgUE+IyhdZ8yrOJ
         0XKuiUqoVdhjijM9jpJalhqie1Ne3r+Rop1oS28mx8JZXwDP+vcc5NYqrhAnLOnO0Dbs
         y0sjGHbmnLBsANXOXVPcoaybaOPi/Lgfp/QyUcgEhsY4IwXqXT5NVHbDEVtcG98XeRI3
         3MJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=NdiXOwE3+fPNEtWzey9w1q7yNkPM+KPTEhOrGKhZWDY=;
        b=WVoNae44dWm+6Fm3qKpsk4zm++FuE/J4Iogph6pGfxOFUA+XPGZBQ27ps6NUv4Jo3D
         M4tBhvKjal7kIA7a68NkPhaLOndvW6HjZvRF406kAHzAByU673cvtQggqn1NhoNghg0K
         gAbnbkz/HYInoF70msKF27n72AvAODptoE0gy1P7mPuozywK2yiDjAawoAMNgx4GxuHa
         4L0cf59RVhRJcw7f/kuKohkSgu5m+wIycJ/tl5BSiQjSqy7k06N5Vunvb1wpycnRoR77
         x9tgbEfOvd05+T6uDoI0dayqcxcpssS+s2NY2iwhN90oktLuOtZ+UqHXmxfMQg56btpM
         0sDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.24 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.24 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kbuild@vger.kernel.org,
	"Yann E. MORIN" <yann.morin.1998@free.fr>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <mmarek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] Kconfig: improve handling for all{rand,yes,no,}.config fragments
Date: Fri, 16 Feb 2018 22:41:12 +0100
Message-Id: <20180216214117.1947175-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180216214117.1947175-1-arnd@arndb.de>
References: <20180216214117.1947175-1-arnd@arndb.de>
X-Provags-ID: V03:K0:DsySdBUpNFt+e/nzmYwfqzjYZjpj13re5X7xnJx5gyI1Eeyc/8O
 bvSkfnghSQX638gGp1PkFzOa8i6l8rZvtOekkUkm1aaURKIKb0py02Wfc7Dok9JVN4WJqbD
 0SaUzZwHPEVI5+wagKrKHx9y0gdbrZ8M+lGGMHuK6Ejpeg2UAaiyYla/BwdyCY26nNbxjTl
 61spnBBv+c9zB3bUKcaZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7V4FJictevY=:MRXOYVnDOsHw/syrtJvLz5
 xH+99PCW/BbtlcdQB8gIbbMFI0VNPbAITFuTovVKfhL0oUgZbB7L9BHHsPo+rdXny+FZAW4Bv
 s9jSQRsStEMj/Y8/3+FDPUoBGNNMCk/NXO8ltMLGNTmis+WA1JaG7g2MEEpPu3CE11m+l28h6
 ECkJQfaBKgG/uMuXYkKn+UTy+TPONESYjb6vwwINYh2bcpq+1AcCv9nTM+n6J+injfx3CzMot
 KpYK2r9WNlNIitPlpPTSigwqfa+tSLnk4kQTOpENteXZwxx7lFt7zjQKp/1mtaAoWQLvX3Ffw
 K7JLV/NehWkd9jGDt3vefPV+J16e4JkN9yOqhRUk/zqX1pOhUZMe1qWrhwDVlPQZxpJ4pKQ77
 4O0qapEQjuqCWot40KXVTsUmmmw7P68REVVvwFNagkZ1CQRUbwofsfvZvzpy6B4t59DhYKL9o
 tXhRh22PqRbEmX1UYkmePzQ62lDtE5UCFdVv4eX4U1enf6EF5afVg18KqYLh9HZKQu1ZDsjxX
 PROUbAxNVoHrENZqNQCg2592TQElwVrLKbCzPOgscJWXFWgZmOlv2AfoA5IaAmG0qtOpTgz1s
 EZjvbZn1O/Cq379oGZYMO4piSQK1g+Gxl7GgCUuLXivBeV1bWL8QdPfvUHH1M8MdzsdbMLRU7
 MYDtldFcfoHfjKoXrX+O1E5ZYyOsbI4ThWjizDyyZ3e+2d3xJL6YlMxkt01zRwdvzROflqYAd
 iQy7rFga0BAcJHX4ZOmdN+5Mcz5YuoyWGytcKQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595410017482900?=
X-GMAIL-MSGID: =?utf-8?q?1592595410017482900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel currently supports two methods of dealing with config
fragments in the tree:

a) Running "make foo.config" looks for arch/$(ARCH)/configs/foo.config
   and kernel/configs/foo.config, and applies the defaults from those
   files on top of the current configuration.

b) Running "KCONFIG_ALLCONFIG=1 make randconfig" (or the equivalent
   allmodconfig/allnoconfig/allyesconfig/alldefconfig) will look
   for a "allrandconfig.config" file in the current directory or the
   top of the $(srctree). These are used as defaults before we generate
   the remaining options.

This is rather inconsistent, and prevents us from easily shipping
good defaults for "randconfig". I'm extending the logic here so that
the second case also looks for the hardcoded file names in the standard
directories (first arch/$(ARCH)/configs/, then kernel/configs) in the
source tree.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/kconfig/conf.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 866369f10ff8..848bf4d15e9a 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -493,8 +493,9 @@ int main(int ac, char **av)
 {
 	const char *progname = av[0];
 	int opt;
-	const char *name, *defconfig_file = NULL /* gcc uninit */;
+	const char *arch, *name, *defconfig_file = NULL /* gcc uninit */;
 	struct stat tmpstat;
+	char fullname[PATH_MAX+1];
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -621,14 +622,24 @@ int main(int ac, char **av)
 		case randconfig:	name = "allrandom.config"; break;
 		default: break;
 		}
-		if (conf_read_simple(name, S_DEF_USER) &&
-		    conf_read_simple("all.config", S_DEF_USER)) {
-			fprintf(stderr,
-				_("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
-				name);
-			exit(1);
+		/* try ./name, arch/$(ARCH)/configs/name and kernel/config/name */
+		if (!conf_read_simple(name, S_DEF_USER))
+			break;
+		arch = getenv("ARCH");
+		if (arch) {
+			snprintf(fullname, sizeof(fullname), "arch/%s/configs/%s",
+				 arch, name);
+			if (!conf_read_simple(fullname, S_DEF_USER))
+				break;
 		}
-		break;
+		snprintf(fullname, sizeof(fullname), "kernel/configs/%s", name);
+		if (!conf_read_simple(fullname, S_DEF_USER))
+			break;
+
+		fprintf(stderr,
+			_("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
+				name);
+		exit(1);
 	default:
 		break;
 	}
-- 
2.9.0
