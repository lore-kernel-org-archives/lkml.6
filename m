Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ZZO/LDuVgpI4/GyPssHCMAGXMTl7UfYYlPaN961GRPzwjSvGXoQNYxcc1bB5wr5W4YlLN
ARC-Seal: i=1; a=rsa-sha256; t=1519411020; cv=none;
        d=google.com; s=arc-20160816;
        b=p3p/GijbNzWoLzQT8Gt6LmVsaelf1yorO/+yqYitkD53QTjiirZdZcLYyBJ+NnBBRw
         gliUmySYrwqlNnRWv+lDWnU9mJ3YGweiZFOP2d6AxwLeTbDk/x9fSU+dNPjPffe0PwTB
         sItSTt3mOxjTHd4LmSxGGXlellQAiGy8LHG7Xw7EnSDwUMSIJdsbBwGn80ZxY0rxWHUg
         rwpjbA5+cJ2iRgEKoXvwE4q6KJBD7ITAmtMkG8FqhlvcTQPi9UJ7XKD2IdAIdn7QnN+x
         W/4SRwHGvqtKcjMcECrB1xEZjWROSLQnKLPR4arNAx31+Gni6DzbZJkSD53yor9N8ZGX
         +luA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=st+zQrHebBP/F9IwvDj6RTquWRbzr2LunVebVkqqL40=;
        b=wxFUduebQdR/MaXDKUE/QnGDID7D1ypRli3+pWpGc+V7TqbPbcO1fA8RVhaGqb4Nzn
         yJib5yoWosTZ+vxISUmveQDe0aLuJvWABKNpKBdGmzHcveqP9d5fqwMEKnVjA5qLqRmS
         8X7jm3u9GflRrWbzEZIYKwOw9MrWVCpRMFSmXNRgJ31ODNED6pvXutVMdsw1NgrzgwnU
         cUSgBzpajmD8h+Ko6YbAxVbmoIJN86bPQVjj8+3USvXj11vi+hEzcuQv5kySTagrsOq2
         20h0yqRo1tWGpksC9j1Qy4zYBduFZGsMfIsu7cnnEAcJj/XxSKbRUA/MnribGtsXm9mp
         BZJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4.4 093/193] video: fbdev: sis: remove unused variable
Date: Fri, 23 Feb 2018 19:25:26 +0100
Message-Id: <20180223170340.563013348@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217930044747386?=
X-GMAIL-MSGID: =?utf-8?q?1593217930044747386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit 32ad61951574d011d363694d6037592e99da9421 upstream.

The variables modeflag and resinfo were only assigned some value but
were never used.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/sis/init301.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -2151,17 +2151,15 @@ SiS_GetVCLK2Ptr(struct SiS_Private *SiS_
 		unsigned short RefreshRateTableIndex)
 {
   unsigned short CRT2Index, VCLKIndex = 0, VCLKIndexGEN = 0, VCLKIndexGENCRT = 0;
-  unsigned short modeflag, resinfo, tempbx;
+  unsigned short resinfo, tempbx;
   const unsigned char *CHTVVCLKPtr = NULL;
 
   if(ModeNo <= 0x13) {
-     modeflag = SiS_Pr->SiS_SModeIDTable[ModeIdIndex].St_ModeFlag;
      resinfo = SiS_Pr->SiS_SModeIDTable[ModeIdIndex].St_ResInfo;
      CRT2Index = SiS_Pr->SiS_SModeIDTable[ModeIdIndex].St_CRT2CRTC;
      VCLKIndexGEN = (SiS_GetRegByte((SiS_Pr->SiS_P3ca+0x02)) >> 2) & 0x03;
      VCLKIndexGENCRT = VCLKIndexGEN;
   } else {
-     modeflag = SiS_Pr->SiS_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
      resinfo = SiS_Pr->SiS_EModeIDTable[ModeIdIndex].Ext_RESINFO;
      CRT2Index = SiS_Pr->SiS_RefIndex[RefreshRateTableIndex].Ext_CRT2CRTC;
      VCLKIndexGEN = SiS_Pr->SiS_RefIndex[RefreshRateTableIndex].Ext_CRTVCLK;
@@ -7270,7 +7268,7 @@ SiS_ShiftXPos(struct SiS_Private *SiS_Pr
 static void
 SiS_SetGroup4_C_ELV(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned short ModeIdIndex)
 {
-   unsigned short temp, temp1, resinfo = 0;
+   unsigned short temp, temp1;
    unsigned char  *ROMAddr = SiS_Pr->VirtualRomBase;
 
    if(!(SiS_Pr->SiS_VBType & VB_SIS30xCLV)) return;
@@ -7282,10 +7280,6 @@ SiS_SetGroup4_C_ELV(struct SiS_Private *
       if(!(ROMAddr[0x61] & 0x04)) return;
    }
 
-   if(ModeNo > 0x13) {
-      resinfo = SiS_Pr->SiS_EModeIDTable[ModeIdIndex].Ext_RESINFO;
-   }
-
    SiS_SetRegOR(SiS_Pr->SiS_Part4Port,0x3a,0x08);
    temp = SiS_GetReg(SiS_Pr->SiS_Part4Port,0x3a);
    if(!(temp & 0x01)) {
