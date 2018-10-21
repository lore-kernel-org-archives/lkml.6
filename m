Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6ACECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 10:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706EF2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 10:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kitiht7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706EF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJUSPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 14:15:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37149 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeJUSPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 14:15:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 185-v6so7474663wmt.2;
        Sun, 21 Oct 2018 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rs/Pc2mdKkfwM4nIYQeAa2UurEq0DQr/3G5Qx9n+B8A=;
        b=Kitiht7u9BZqOUwQ5inC9+KjD4yhn2Trv8h5A2ZwDXqZzj5wik/RW9yTV46Xllrkyv
         YKDNvZTtlwe/Nodn5teH5vAwS7V5u4BeuAujKSDXIJlZdAV0BpvQvjytI5qsqsMrgZWi
         PQxAkNT3RAus5kKjefjenbIyrtL5K0Sok4VGGL1krvuFJ8oHMmMCQ3VI2AfV7pgNzbql
         0PnZdTygV936zJzya62gLyN8CbQpOaLc2pNgm9nVkyM34QgQiC1W/ZrpKh3hzA6pNHNe
         Y8cxWfhH8IcHUxAmr+jULqaYB156Ufk7MY7SY6oB2HLiycuy8iLEsUdcKIPektA5kFMX
         ayQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rs/Pc2mdKkfwM4nIYQeAa2UurEq0DQr/3G5Qx9n+B8A=;
        b=gE9gkB76xgYdJTtaxEamxY+RG3PMu+jKW+qByO6seHQQsWKWqqY+nO+Bn76R+sWnPL
         SbWYGahEZYVu9LsBfRQtEgVRfUbneH2mscjVtROCowP9xtsc1b4WPz1odk6KkeVJVZ9C
         WiTHtTkzB30ivmTDNbFcejyAwIpBo7Gmjx1ZTnktSWm5prpgCN9zpKfXC1tNeKVuLOR1
         HGtqcFzNAnx/aXluMks0dRnp5TxzugvyH6qyNZct1WeNUM5ebkIqkdzrQ1Yd5Cc14S0r
         VcTBz+R3sAx0a0bF8JQW7gkoqJblo2fTcvno8YlSMosht7nWC0wKnGbcEoQ1AIU4Wsq9
         UqLA==
X-Gm-Message-State: ABuFfojlAAVtWnwxqsC82paLjLRbfbAZUEy134VkJcC7np7Tya6AmnG3
        KFmNln6LpxCxp2yZDnXk23k=
X-Google-Smtp-Source: ACcGV608vsuPi1sMeJ6+s/uitWqngOW5kLigOx0/2z9cKDTgRuqU8u8EqxyuaKEiuHDHrAnKZsPhug==
X-Received: by 2002:a1c:aa05:: with SMTP id t5-v6mr12083302wme.71.1540116117325;
        Sun, 21 Oct 2018 03:01:57 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-231-174.clienti.tiscali.it. [78.12.231.174])
        by smtp.googlemail.com with ESMTPSA id e196-v6sm19216152wmf.43.2018.10.21.03.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 03:01:56 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in kvm_put_kvm
To:     syzbot <syzbot+f87f60bb6f13f39b54e3@syzkaller.appspotmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
References: <000000000000bc23740578abe82c@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <3ad5acd8-5c73-1d82-aea5-426e598b15ed@redhat.com>
Date:   Sun, 21 Oct 2018 12:01:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <000000000000bc23740578abe82c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2018 18:57, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d808b5400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=f87f60bb6f13f39b54e3
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cf2f5e400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1036dcce400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f87f60bb6f13f39b54e3@syzkaller.appspotmail.com

Tentative (untested) patch:

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 3710342cf6ad..dc76cc8d24fd 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -90,6 +90,7 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
 	return 0;
 }

+/* called with kvm->slots_lock held */
 static void coalesced_mmio_destructor(struct kvm_io_device *this)
 {
 	struct kvm_coalesced_mmio_dev *dev = to_mmio(this);
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index b20b751286fc..001e1ef18c8c 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -741,8 +741,8 @@ ioeventfd_write(struct kvm_vcpu *vcpu, struct
kvm_io_device *this, gpa_t addr,
 }

 /*
- * This function is called as KVM is completely shutting down.  We do not
- * need to worry about locking just nuke anything we have as quickly as
possible
+ * This function is called as KVM is completely shutting down, so there
+ * are no RCU readers anymore. Called with kvm->slots_lock held.
  */
 static void
 ioeventfd_destructor(struct kvm_io_device *this)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index aff1242b7af7..e6f2ae6fedcd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -783,6 +783,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	list_del(&kvm->vm_list);
 	spin_unlock(&kvm_lock);
 	kvm_free_irq_routing(kvm);
+	mutex_lock(&kvm->slots_lock);
 	for (i = 0; i < KVM_NR_BUSES; i++) {
 		struct kvm_io_bus *bus = kvm_get_bus(kvm, i);

@@ -790,6 +791,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 			kvm_io_bus_destroy(bus);
 		kvm->buses[i] = NULL;
 	}
+	mutex_unlock(&kvm->slots_lock);
 	kvm_coalesced_mmio_free(kvm);
 #ifdef KVM_DIRTY_LOG_PAGE_OFFSET
 	if (kvm->dirty_ring_size)

