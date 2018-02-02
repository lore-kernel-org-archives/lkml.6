Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226L5jTb0E2F07T1rZk+tF8YfzfF33wOx0qG/3TfePxKG2RwnGThfrsYsTzvFNzMyOsgLh6+
ARC-Seal: i=1; a=rsa-sha256; t=1517591297; cv=none;
        d=google.com; s=arc-20160816;
        b=haB/3C0Q2R1Zs9CTg0+oYtriZoEXBPKZcLrnALVVVo6MUWLOmflK7yDnR50QxBEV/y
         reUE2FBYfRG9GReZqqnmcGvxc1uY1HA2JLUGr0UDVtuNKADOVYeYygWUlBVs+qc7hlQS
         O5csn7nptSc51tcVkTPPkfdI0IP4LCEMqCaUj7dzLfHvSKYlH8ua+sEhW7sJKSaZ2XYT
         aut7M/s6ZKJ46qlLsFNFjWxPqLrOMP//t30GVmL+zoiZ8k5ccfefM3evI21tNAnOkfnD
         GIxH6EFpvRV8Zd7zlPTbsFgYNK30aY4cjCEMjF+5FJy0ipxxMv5rf6+0SB6BoRd/hsxd
         RaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MYB7TqDQgg6+TKo7BWFCDcXsb4yL6s8eeLxB/8ZAJeg=;
        b=Wx6Bh+8U4/YkFMLoKwDYLiRC4HTkfuDZU9GP4gofov/a8wBejM3ucE1hlx68Dt6s+h
         VHHz7bDNJQXiYFXKMdQKwi7MD1RyeEIkif1YTkUWdscfPQJlAekl7MFOJo2o7AvNOCI1
         7rBN/KWFbfRgoW0oi1daf0NX84pmtQZq0LUX7KK3lJV3YQtm1oXp4bi+cG/TsfxLT189
         vVBferVXdiNdYPFdMXTbrYMvL3RAtQVT9iUVNefmLA+d4welZGKC5ceptTi1yH8DFl3Y
         BelNetHeKkukWUZwdNP4dIXOMhbe6pxQp1Bzp1mf1mjkxWEfzE4JNx3f821HrbOCz5m5
         QsnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
	Jim Mattson <jmattson@google.com>,
	Krish Sadhukhan <krish.sadhukhan@oracle.com>,
	Borislav Petkov <bp@suse.de>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.14 003/156] KVM: x86: Fix CPUID function for word 6 (80000001_ECX)
Date: Fri,  2 Feb 2018 17:56:24 +0100
Message-Id: <20180202140840.396238366@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309812139806221?=
X-GMAIL-MSGID: =?utf-8?q?1591309812139806221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>

commit 50a671d4d15b859f447fa527191073019b6ce9cb upstream.

The function for CPUID 80000001 ECX is set to 0xc0000001. Set it to
0x80000001.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Fixes: d6321d493319 ("KVM: x86: generalize guest_cpuid_has_ helpers")
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/cpuid.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -44,7 +44,7 @@ static const struct cpuid_reg reverse_cp
 	[CPUID_8086_0001_EDX] = {0x80860001, 0, CPUID_EDX},
 	[CPUID_1_ECX]         = {         1, 0, CPUID_ECX},
 	[CPUID_C000_0001_EDX] = {0xc0000001, 0, CPUID_EDX},
-	[CPUID_8000_0001_ECX] = {0xc0000001, 0, CPUID_ECX},
+	[CPUID_8000_0001_ECX] = {0x80000001, 0, CPUID_ECX},
 	[CPUID_7_0_EBX]       = {         7, 0, CPUID_EBX},
 	[CPUID_D_1_EAX]       = {       0xd, 1, CPUID_EAX},
 	[CPUID_F_0_EDX]       = {       0xf, 0, CPUID_EDX},
