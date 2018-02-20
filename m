Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x225XJMO+JdLQlqPc0XN1Dr5H0NNwwQxSoenS4R+Ig47IcnifdxHYV+BwQLSoYkVdw6dH4P4n
ARC-Seal: i=1; a=rsa-sha256; t=1519127954; cv=none;
        d=google.com; s=arc-20160816;
        b=Dbt5MnyQeNr8wfyfFxgQLKs0EIqREPCZCbscl4b3Lxv0Y89Y7U3tlnAtdbhmEb8XPu
         VHRgnWNf9ihxs6Uq09MhD3FtI1P3Ph5GyomLbKPc+mlRpYlwfS3PLO2iDW3/IjZnHM1F
         ogcjgFKMCXmusG5N7YOM2t+wfxikJjglE2l/2bRNJL6Y65sNIadY2Qv+7Yl70fLtVBj4
         oxCiVw/rVfwRB9Ehv5vVhGECmlb7hf3R5vQLo39YpPWjrqBa7FVi18uR/7MpPp3ATNDZ
         6tmJZf1z7NMOAGVQN9+kvF0PqMPfmom9Yuug15StXciuKLgSVO5mXPUD4ygNC/ectfIP
         esjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=w/kY3moN5fjW4Ri+T2lNxreXwUdwZ9LA7wrDaiuBch4=;
        b=NGpufuRvjbZYB261PgkK+IiZ5/sEwJSH8MPlCl4HmuGiOzanf136NFeXy6gMx6xBRt
         2yCoMCMqAJ97LezsmrtgUoH7I86X4nicfHWmj/9MZgHxGnkKvQlf48DxbLQYwEVnx1N4
         lAq6DVLzi8mpKoEZDFFBSrTkeKoh6dIiT2M2dDCijGLEV5wIe6goXvZtkfXZPKBcR/sL
         nz8gRu9eLdGAbOf7O1DUtAGHCz26ClTU7RTAgVML16LB1Mh9AwQOZPCs9YnuETLQNQLp
         4F632WXUQFPmWlHXkp/GrfNc0UX01BpK3aeRurTsvC8foC+wSc4tBNOHYyfQrSCz/Ul0
         aCBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.13 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.13 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Ladi Prosek <lprosek@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux-foundation.org
Subject: [4.4-stable 12/22] virtio_balloon: prevent uninitialized variable use
Date: Tue, 20 Feb 2018 12:54:59 +0100
Message-Id: <20180220115527.1806578-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:0VKTfdRl6SaYrJSHj7Om8/QLHR38aWGMcre6ZIb4quAvbOxCECo
 pVBp4jC/p3dkLIoYJom3agahCD9y33MMA09eFeJ5YdfyVY3eFyIT3SVXbewD5eXdiHjEvxI
 12Dw1GX720ZU3GGt6sAhmcTNq48sUEq5b6bxzxBqvi4PGdoUc0oo3ObEg2ybuZNmxOzNJpE
 eXeeyMMGaCjoc0ffRc2wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j4tCJBnc6dA=:VoU56uRUIBmij9nA9AeV0/
 xpNmbA9p4+fexTqlY1q5kpLSkI9u9ygfSk9GhTRLlDvbDbCS/RMAmsr5mZpntZluBG/7jnK1a
 pVuSj2gIG40wpAu1mI+Wl+AJuUw3mSzMG8A5AlwUjJKDNYA4s1bfSHtwYBVpE4lmgI+aYknyj
 bjf3m30yQWwlp8OdKogvr62VTD78PtqIiNeZY6FtdjsPWnwP7xGm6w+nsaaob0yFEus5RJDIA
 a/wFeeshcajciDdFqtLjgdW2/dqj/HFnpzh0UNFPqN+ENLC11HVNcnJRvAeH+bJ12///O7OKk
 GktK529+zh3AGuTViMAkojKxExzLlr80SJ6qi/FPUzN+vngtMVEC9zCa2UXjyLU5sN9DsSNDl
 jb5CWGm67ZjyZzfo2iRczC5qxuW+RK5JXU7oaHXyERz93n7g6607IOHE8JvzAxh/lVzrh61Nl
 UXGghAByuv91JdVx9ChGcj5FajieLQXayUPLufUnLtob5Yo53QzNF2PcqN3zucT7REa9Oegem
 37AnI1jQk9PrLvnI8dWrduPRzzqVE6efp/p20ibrge9bA5wTTL2rPrdJD7BABmtaQPWIwzvqh
 P/r07SDRpQ51XOVGuvEiGPeE9ISHLm/fcuxZOlMxun4eoC6UtmRXb0ZJB3YASOcM/xXERD1Yb
 YZqU8u5Q33+Pt7+PIFhmzUxSUcEYWu09EP5op63v3WMwDWgjD0IPLXxHoHHewesMSX+K1rWjV
 yAIgFvnvVjqdDD2uRIRc5Vt0Zmi9Xz5f47bfcw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921114203483749?=
X-GMAIL-MSGID: =?utf-8?q?1592921114203483749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit f0bb2d50dfcc519f06f901aac88502be6ff1df2c upstream.

The latest gcc-7.0.1 snapshot reports a new warning:

virtio/virtio_balloon.c: In function 'update_balloon_stats':
virtio/virtio_balloon.c:258:26: error: 'events[2]' is used uninitialized in this function [-Werror=uninitialized]
virtio/virtio_balloon.c:260:26: error: 'events[3]' is used uninitialized in this function [-Werror=uninitialized]
virtio/virtio_balloon.c:261:56: error: 'events[18]' is used uninitialized in this function [-Werror=uninitialized]
virtio/virtio_balloon.c:262:56: error: 'events[17]' is used uninitialized in this function [-Werror=uninitialized]

This seems absolutely right, so we should add an extra check to
prevent copying uninitialized stack data into the statistics.
>From all I can tell, this has been broken since the statistics code
was originally added in 2.6.34.

Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[arnd: backported to 4.4]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/virtio/virtio_balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 01d15dca940e..26d0dff069f0 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -239,12 +239,15 @@ static void update_balloon_stats(struct virtio_balloon *vb)
 	all_vm_events(events);
 	si_meminfo(&i);
 
+
+#ifdef CONFIG_VM_EVENT_COUNTERS
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
 				pages_to_bytes(events[PSWPIN]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_OUT,
 				pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+#endif
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
 				pages_to_bytes(i.freeram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,
-- 
2.9.0
