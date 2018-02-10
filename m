Return-Path: <sergeev917@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518282672; cv=none;
        d=google.com; s=arc-20160816;
        b=SQgy7IWGAYb8MnJu3CzYe17MCKn76y7SGK0hLE0iYoZYgU3TAbioP8ZUKjdAfT3SDo
         vVHbu35k4UWGPDyCvahj1xgJZNReOn3Mf8jOsQmk309o1itdNPvyxr3Un/LfgGWulCFt
         t4H9kU6WIDvRJjiwgPjDd8YyhQEC4nVWki3WQUuWXZxIboSoFnDQTilZ7e7aEdkmDlWm
         pzkq7hpCp3/mc5xCbfzEEKASdmaRtq4gJGUwHA2oNlJGN+eOH5UvmGuIR9Pik0/BwH+9
         KIKEKvv3D3cDLsKrduMxnfwwL7uL8Is7MTgzlZmpdeQqkqO54LtX83CTjKMOEoI8z/Mj
         eG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=lHeKs0zOnvAwG25zOTpta6RoUWmQKGEwXdPvNrBWK0g=;
        b=U6+vGRs2QZhaJlVg+sWPhTRmjYJS8DyQIFsN8AeRS94tWA2VLnaKO4IrFtYOS2ULBs
         MlHKfxkkmI0GndavzGZt6rfLpPt6780HR9JeG9z3zLZJ8C/PilyDvSgREDNzf8rFIHqC
         GS1r17gQi4BaahmhHHCMCTpvEk+SETurzKwshL3qNNviDCjt+CoKdxSYLmtoQ4ijRMWE
         zrVCE6z4AJ3pP2Kntf0UDUfr5NafhRYlK4PTFTR6OJclzZ+k0K5WBOP3bcSbkKntVLj9
         HfUa2mMuJmF2Bg6j5Ij3J9DJYHwxVW1o98PblLVy+itrpR2CWe8md8BIXNhScjzTaYTY
         nrTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=neNBevRb;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=neNBevRb;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226FKyN4hXPCgS6FHkc4FZUjrc3UEen24gbA0BBWou1ixuVR0ReVDkKhqaYVmj8A1Px4Cxjbkg==
Date: Sat, 10 Feb 2018 20:14:59 +0300
From: Alexander Sergeyev <sergeev917@gmail.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Kyle Huey <me@kylehuey.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: update spectre v2 microcodes blacklist
Message-ID: <20180210171459.GA12797@localhost.localdomain>
References: <20180210123123.GA19396@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20180210123123.GA19396@localhost.localdomain>
User-Agent: mtt
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592016927852230730?=
X-GMAIL-MSGID: =?utf-8?q?1592034772248498862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

>I didn't fully match the updated revision guidance and spectre_bad_microcodes

I compared these lists and it seems that the only difference is about skylakes. 
Everything else is covered by less-or-equal criteria on revision version.

Both desktop and mobile skylakes are stated to be unaffected for 0xC2:

{ INTEL_FAM6_SKYLAKE_DESKTOP,    0x03, 0xc2 }, // signature 0x000506E3
{ INTEL_FAM6_SKYLAKE_MOBILE,     0x03, 0xc2 }, // signature 0x000406E3

I reformated the Intel bulletin into json format for ease of automation and 
batch processing -- it is attached.

Raw diff between the mainline blacklist and the bulletin looks like:
@@ -1,5 +1,6 @@
 { INTEL_FAM6_BROADWELL_CORE,     0x04, 0x28 },
 { INTEL_FAM6_BROADWELL_GT3E,     0x01, 0x1b },
+{ INTEL_FAM6_BROADWELL_X,        0x01, 0x0b000023 },
 { INTEL_FAM6_BROADWELL_X,        0x01, 0x0b000025 },
 { INTEL_FAM6_BROADWELL_XEON_D,   0x02, 0x14 },
 { INTEL_FAM6_BROADWELL_XEON_D,   0x03, 0x07000011 },
@@ -9,12 +10,10 @@
 { INTEL_FAM6_HASWELL_X,          0x02, 0x3b },
 { INTEL_FAM6_HASWELL_X,          0x04, 0x10 },
 { INTEL_FAM6_IVYBRIDGE_X,        0x04, 0x42a },
-{ INTEL_FAM6_KABYLAKE_DESKTOP,   0x09, 0x84 },
-{ INTEL_FAM6_KABYLAKE_DESKTOP,   0x0a, 0x84 },
-{ INTEL_FAM6_KABYLAKE_DESKTOP,   0x0b, 0x84 },
-{ INTEL_FAM6_KABYLAKE_MOBILE,    0x09, 0x84 },
-{ INTEL_FAM6_KABYLAKE_MOBILE,    0x0a, 0x84 },
-{ INTEL_FAM6_SKYLAKE_DESKTOP,    0x03, 0xc2 },
-{ INTEL_FAM6_SKYLAKE_MOBILE,     0x03, 0xc2 },
-{ INTEL_FAM6_SKYLAKE_X,          0x03, 0x0100013e },
+{ INTEL_FAM6_KABYLAKE_DESKTOP,   0x09, 0x80 },
+{ INTEL_FAM6_KABYLAKE_DESKTOP,   0x0a, 0x80 },
+{ INTEL_FAM6_KABYLAKE_DESKTOP,   0x0b, 0x80 },
+{ INTEL_FAM6_KABYLAKE_MOBILE,    0x09, 0x80 },
+{ INTEL_FAM6_KABYLAKE_MOBILE,    0x0a, 0x80 },
+{ INTEL_FAM6_SKYLAKE_X,          0x04, 0x0200003a },
 { INTEL_FAM6_SKYLAKE_X,          0x04, 0x0200003c },

Note: Gemini Lake and Sandy Bridge are not considered (observed in wild).

--BXVAT5kNtrzKuDFl
Content-Type: application/json
Content-Disposition: attachment; filename="microcode-update-guidance.json"
Content-Transfer-Encoding: quoted-printable

[=0A  {=0A    "cpuid":"506A0",=0A    "new production mcu rev":"00000039",=
=0A    "platfrorm id":"01",=0A    "pre-mitigation product mcu":"---",=0A   =
 "product names":"Anniedale > Moorefield",=0A    "production status":"Produ=
ction",=0A    "public name":"Intel=C2=AE Atom=C2=AE Processor Z3530, Z3560,=
 Z3570, Z3580, Z3590",=0A    "sku_microcode.model":"INTEL_FAM6_ATOM_MOOREFI=
ELD",=0A    "sku_microcode.stepping":"0x00",=0A    "stop deploying these mc=
u revs":"---"=0A  },=0A  {=0A    "cpuid":"506C9",=0A    "new production mcu=
 rev":"0000002E",=0A    "platfrorm id":"03",=0A    "pre-mitigation product =
mcu":"---",=0A    "product names":"\nApollo Lake",=0A    "production status=
":"Production",=0A    "public name":"Intel=C2=AE Celeron=C2=AE & Pentium=C2=
=AE Processor Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_ATOM=
_GOLDMONT",=0A    "sku_microcode.stepping":"0x09",=0A    "stop deploying th=
ese mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"506CA",=0A    "new producti=
on mcu rev":"00000008",=0A    "platfrorm id":"03",=0A    "pre-mitigation pr=
oduct mcu":"---",=0A    "product names":"\nApollo Lake",=0A    "production =
status":"Production",=0A    "public name":"Intel=C2=AE Pentium=C2=AE J4205,=
 N4200\nIntel=C2=AE Celeron=C2=AE J3355, J3455, N3350, N3450\nIntel=C2=AE A=
tom=C2=AE x5-E3930, x5-E3940, x7-E3950\nIntel=C2=AE Atom=C2=AE A39xx Produc=
t Family",=0A    "sku_microcode.model":"INTEL_FAM6_ATOM_GOLDMONT",=0A    "s=
ku_microcode.stepping":"0x0A",=0A    "stop deploying these mcu revs":"---"=
=0A  },=0A  {=0A    "cpuid":"20655",=0A    "new production mcu rev":"---",=
=0A    "platfrorm id":"92",=0A    "pre-mitigation product mcu":"0x4",=0A   =
 "product names":"\nArrandale, Clarkdale",=0A    "production status":"Plann=
ing",=0A    "public name":"Intel=C2=AE Celeron=C2=AE Mobile P4xxx, U3xxx Pr=
ocessor\nIntel=C2=AE Pentium=C2=AE Mobile P6xxx, U5xxx Processor\nIntel=C2=
=AE Core=E2=84=A2 i3-3xxE, i3-3xxM, i3-3xxUM Processor\nIntel=C2=AE Core=E2=
=84=A2 i5-4xxM/UM, i5-5xxE/M/UM Processor\nIntel=C2=AE Core=E2=84=A2 i7-6xx=
E/LE/UE/M/LM/UM Processor",=0A    "sku_microcode.model":"INTEL_FAM6_WESTMER=
E",=0A    "sku_microcode.stepping":"0x05",=0A    "stop deploying these mcu =
revs":"---"=0A  },=0A  {=0A    "cpuid":"20652",=0A    "new production mcu r=
ev":"---",=0A    "platfrorm id":"12",=0A    "pre-mitigation product mcu":"0=
xE",=0A    "product names":"Arrandale, Clarkdale, Clarkdale\nXeon",=0A    "=
production status":"Planning",=0A    "public name":"Intel=C2=AE Xeon=C2=AE =
Processor L3406",=0A    "sku_microcode.model":"INTEL_FAM6_WESTMERE",=0A    =
"sku_microcode.stepping":"0x02",=0A    "stop deploying these mcu revs":"---=
"=0A  },=0A  {=0A    "cpuid":"406D8",=0A    "new production mcu rev":"00000=
129",=0A    "platfrorm id":"01",=0A    "pre-mitigation product mcu":"---",=
=0A    "product names":"\nAvoton/Rangeley",=0A    "production status":"Prod=
uction",=0A    "public name":"Intel=C2=AE Atom=C2=AE Processor C2000 Produc=
t Family",=0A    "sku_microcode.model":"INTEL_FAM6_ATOM_SILVERMONT2",=0A   =
 "sku_microcode.stepping":"0x08",=0A    "stop deploying these mcu revs":"--=
-"=0A  },=0A  {=0A    "cpuid":"106A4",=0A    "new production mcu rev":"---"=
,=0A    "platfrorm id":"03",=0A    "pre-mitigation product mcu":"0x12",=0A =
   "product names":"\nBloomfield",=0A    "production status":"Planning",=0A=
    "public name":"Intel=C2=AE Core=E2=84=A2 i7-965/975 Extreme Processor\n=
Intel=C2=AE Core=E2=84=A2 i7-9x0 Processor",=0A    "sku_microcode.model":"I=
NTEL_FAM6_NEHALEM_EP",=0A    "sku_microcode.stepping":"0x04",=0A    "stop d=
eploying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"106A5",=0A    "n=
ew production mcu rev":"---",=0A    "platfrorm id":"03",=0A    "pre-mitigat=
ion product mcu":"0x19",=0A    "product names":"\nBloomfield, Nehalem EP,\n=
Nehalem WS",=0A    "production status":"Planning",=0A    "public name":"Int=
el=C2=AE Core=E2=84=A2 i7-920 Processor",=0A    "sku_microcode.model":"INTE=
L_FAM6_NEHALEM_EP",=0A    "sku_microcode.stepping":"0x05",=0A    "stop depl=
oying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"50665",=0A    "new =
production mcu rev":"---",=0A    "platfrorm id":"10",=0A    "pre-mitigation=
 product mcu":"---",=0A    "product names":"\nBroadwell DE A1",=0A    "prod=
uction status":"Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Processo=
r D-1500 NS Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_BROADW=
ELL_XEON_D",=0A    "sku_microcode.stepping":"0x05",=0A    "stop deploying t=
hese mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"50662",=0A    "new product=
ion mcu rev":"---",=0A    "platfrorm id":"10",=0A    "pre-mitigation produc=
t mcu":"0x11",=0A    "product names":"Broadwell DE V1",=0A    "production s=
tatus":"Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Processor D-1500=
 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_BROADWELL_XEON_D"=
,=0A    "sku_microcode.stepping":"0x02",=0A    "stop deploying these mcu re=
vs":"0x14"=0A  },=0A  {=0A    "cpuid":"50663",=0A    "new production mcu re=
v":"---",=0A    "platfrorm id":"10",=0A    "pre-mitigation product mcu":"0x=
700000C",=0A    "product names":"Broadwell DE V2,V3",=0A    "production sta=
tus":"Pre-Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Processor D-15=
00 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_BROADWELL_XEON_=
D",=0A    "sku_microcode.stepping":"0x03",=0A    "stop deploying these mcu =
revs":"0x7000011"=0A  },=0A  {=0A    "cpuid":"50664",=0A    "new production=
 mcu rev":"---",=0A    "platfrorm id":"10",=0A    "pre-mitigation product m=
cu":"0xF00000A",=0A    "product names":"Broadwell DE Y0",=0A    "production=
 status":"Pre-Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Processor =
D-1500 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_BROADWELL_X=
EON_D",=0A    "sku_microcode.stepping":"0x04",=0A    "stop deploying these =
mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"40671",=0A    "new production m=
cu rev":"---",=0A    "platfrorm id":"22",=0A    "pre-mitigation product mcu=
":"0x17",=0A    "product names":"Broadwell H 43e",=0A    "production status=
":"Pre-Beta",=0A    "public name":"5th Generation Intel=C2=AE Core=E2=84=A2=
 Mobile Processor Family",=0A    "sku_microcode.model":"INTEL_FAM6_BROADWEL=
L_GT3E",=0A    "sku_microcode.stepping":"0x01",=0A    "stop deploying these=
 mcu revs":"0x1B"=0A  },=0A  {=0A    "cpuid":"406F1",=0A    "new production=
 mcu rev":"---",=0A    "platfrorm id":"EF",=0A    "pre-mitigation product m=
cu":"0x22",=0A    "product names":"Broadwell Server E, EP, EP4S, EX",=0A   =
 "production status":"Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Pr=
ocessor E5v4 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_BROAD=
WELL_X",=0A    "sku_microcode.stepping":"0x01",=0A    "stop deploying these=
 mcu revs":"0xB000023,\n0xB000025"=0A  },=0A  {=0A    "cpuid":"306D4",=0A  =
  "new production mcu rev":"---",=0A    "platfrorm id":"C0",=0A    "pre-mit=
igation product mcu":"0x25",=0A    "product names":"Broadwell U/Y",=0A    "=
production status":"Beta",=0A    "public name":"5th Generation Intel=C2=AE =
Core=E2=84=A2 Processor Family, Intel=C2=AE\nPentium=C2=AE Mobile Processor=
 Family, and Intel=C2=AE Celeron=C2=AE\nMobile Processor Family",=0A    "sk=
u_microcode.model":"INTEL_FAM6_BROADWELL_CORE",=0A    "sku_microcode.steppi=
ng":"0x04",=0A    "stop deploying these mcu revs":"0x28"=0A  },=0A  {=0A   =
 "cpuid":"40671",=0A    "new production mcu rev":"---",=0A    "platfrorm id=
":"22",=0A    "pre-mitigation product mcu":"0x17",=0A    "product names":"B=
roadwell Xeon E3",=0A    "production status":"Pre-Beta",=0A    "public name=
":"Intel=C2=AE Xeon=C2=AE Processor E3-1200 v4 Product Family",=0A    "sku_=
microcode.model":"INTEL_FAM6_BROADWELL_GT3E",=0A    "sku_microcode.stepping=
":"0x01",=0A    "stop deploying these mcu revs":"0x1B"=0A  },=0A  {=0A    "=
cpuid":"506C2",=0A    "new production mcu rev":"00000010",=0A    "platfrorm=
 id":"01",=0A    "pre-mitigation product mcu":"---",=0A    "product names":=
"Broxton",=0A    "production status":"Production",=0A    "public name":"Int=
el=C2=AE Atom=C2=AE Scalable Platform",=0A    "sku_microcode.model":"INTEL_=
FAM6_ATOM_GOLDMONT",=0A    "sku_microcode.stepping":"0x02",=0A    "stop dep=
loying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"60663",=0A    "new=
 production mcu rev":"---",=0A    "platfrorm id":"80",=0A    "pre-mitigatio=
n product mcu":"---",=0A    "product names":"\nCannon Lake U 2+2, 2+0(GT0)"=
,=0A    "production status":"Beta",=0A    "public name":"TBD",=0A    "sku_m=
icrocode.model":"INTEL_FAM6_CANNONLAKE_MOBILE",=0A    "sku_microcode.steppi=
ng":"0x03",=0A    "stop deploying these mcu revs":"---"=0A  },=0A  {=0A    =
"cpuid":"406C3",=0A    "new production mcu rev":"00000367",=0A    "platfror=
m id":"01",=0A    "pre-mitigation product mcu":"---",=0A    "product names"=
:"Cherry View (Cherry Trail,\nBraswell)",=0A    "production status":"Produc=
tion",=0A    "public name":"Intel=C2=AE Atom=C2=AE x5-Zxxxx CPU",=0A    "sk=
u_microcode.model":"INTEL_FAM6_ATOM_AIRMONT",=0A    "sku_microcode.stepping=
":"0x03",=0A    "stop deploying these mcu revs":"---"=0A  },=0A  {=0A    "c=
puid":"406C4",=0A    "new production mcu rev":"00000410",=0A    "platfrorm =
id":"01",=0A    "pre-mitigation product mcu":"---",=0A    "product names":"=
Cherry View (Cherry Trail,\nBraswell)",=0A    "production status":"Producti=
on",=0A    "public name":"Intel=C2=AE Celeron=C2=AE Processor Jxxxx\nIntel=
=C2=AE Celeron=C2=AE Processor N3xxx\nIntel=C2=AE Pentium=C2=AE Processor J=
3xxx\nIntel=C2=AE Pentium=C2=AE Processor N3xxx\nIntel=C2=AE Atom=C2=AE x5-=
E8000 Processor",=0A    "sku_microcode.model":"INTEL_FAM6_ATOM_AIRMONT",=0A=
    "sku_microcode.stepping":"0x04",=0A    "stop deploying these mcu revs":=
"---"=0A  },=0A  {=0A    "cpuid":"106E5",=0A    "new production mcu rev":"-=
--",=0A    "platfrorm id":"13",=0A    "pre-mitigation product mcu":"0x08",=
=0A    "product names":"Clarksfield, Lynnfield, Lynnfield\nXeon",=0A    "pr=
oduction status":"Planning",=0A    "public name":"Intel=C2=AE Core=E2=84=A2=
 i7-7xxQM, i7-8xxQM Processor\nIntel=C2=AE Core=E2=84=A2 i7-9xxXM Extreme P=
rocessor\nIntel=C2=AE Core=E2=84=A2 i5-7xx, i5-7xxS\nIntel=C2=AE Core=E2=84=
=A2 i7-8xx, i7-8xxS, i7-8xxK",=0A    "sku_microcode.model":"INTEL_FAM6_NEHA=
LEM",=0A    "sku_microcode.stepping":"0x05",=0A    "stop deploying these mc=
u revs":"---"=0A  },=0A  {=0A    "cpuid":"906EA",=0A    "new production mcu=
 rev":"---",=0A    "platfrorm id":"22",=0A    "pre-mitigation product mcu":=
"0x70",=0A    "product names":"Coffee Lake H (6+2),\nCoffee Lake S (6+2)",=
=0A    "production status":"Beta",=0A    "public name":"8th Generation Inte=
l=C2=AE Core=E2=84=A2 Processor Family",=0A    "sku_microcode.model":"INTEL=
_FAM6_KABYLAKE_DESKTOP",=0A    "sku_microcode.stepping":"0x0A",=0A    "stop=
 deploying these mcu revs":"0x80"=0A  },=0A  {=0A    "cpuid":"906EA",=0A   =
 "new production mcu rev":"---",=0A    "platfrorm id":"22",=0A    "pre-miti=
gation product mcu":"0x72",=0A    "product names":"Coffee Lake S (6+2) Xeon=
 E3",=0A    "production status":"Beta",=0A    "public name":"8th Generation=
 Intel=C2=AE Core=E2=84=A2 Processor Family",=0A    "sku_microcode.model":"=
INTEL_FAM6_KABYLAKE_DESKTOP",=0A    "sku_microcode.stepping":"0x0A",=0A    =
"stop deploying these mcu revs":"0x80"=0A  },=0A  {=0A    "cpuid":"806EA",=
=0A    "new production mcu rev":"---",=0A    "platfrorm id":"C0",=0A    "pr=
e-mitigation product mcu":"0x70",=0A    "product names":"Coffee Lake U43e",=
=0A    "production status":"Beta",=0A    "public name":"8th Generation Inte=
l=C2=AE Core=E2=84=A2 Processor Family",=0A    "sku_microcode.model":"INTEL=
_FAM6_KABYLAKE_MOBILE",=0A    "sku_microcode.stepping":"0x0A",=0A    "stop =
deploying these mcu revs":"0x80"=0A  },=0A  {=0A    "cpuid":"906EB",=0A    =
"new production mcu rev":"---",=0A    "platfrorm id":"02",=0A    "pre-mitig=
ation product mcu":"0x72",=0A    "product names":"Coffee Lake-S (4+2) + KBL=
 PCH",=0A    "production status":"Beta",=0A    "public name":"8th Generatio=
n Intel=C2=AE Core=E2=84=A2 Desktop Processor Family",=0A    "sku_microcode=
=2Emodel":"INTEL_FAM6_KABYLAKE_DESKTOP",=0A    "sku_microcode.stepping":"0x=
0B",=0A    "stop deploying these mcu revs":"0x80"=0A  },=0A  {=0A    "cpuid=
":"906EB",=0A    "new production mcu rev":"---",=0A    "platfrorm id":"02",=
=0A    "pre-mitigation product mcu":"0x72",=0A    "product names":"Coffee L=
ake-S (4+2) Xeon E3",=0A    "production status":"Pre-Beta",=0A    "public n=
ame":"8th Generation Intel=C2=AE Core=E2=84=A2 Processor Family",=0A    "sk=
u_microcode.model":"INTEL_FAM6_KABYLAKE_DESKTOP",=0A    "sku_microcode.step=
ping":"0x0B",=0A    "stop deploying these mcu revs":"0x80"=0A  },=0A  {=0A =
   "cpuid":"606E1",=0A    "new production mcu rev":"0x105",=0A    "platfror=
m id":"01",=0A    "pre-mitigation product mcu":"---",=0A    "product names"=
:"Cougar Mountain (AMT)",=0A    "production status":"Production",=0A    "pu=
blic name":"Intel=C2=AE Puma=E2=84=A2 7 Home Gateway",=0A    "sku_microcode=
=2Emodel":"0x6E",=0A    "sku_microcode.stepping":"0x01",=0A    "stop deploy=
ing these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"506F1",=0A    "new pr=
oduction mcu rev":"00000020",=0A    "platfrorm id":"01",=0A    "pre-mitigat=
ion product mcu":"---",=0A    "product names":"Denverton (GLM)",=0A    "pro=
duction status":"Production",=0A    "public name":"Intel=C2=AE Atom=C2=AE P=
rocessor C3000 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_ATO=
M_DENVERTON",=0A    "sku_microcode.stepping":"0x01",=0A    "stop deploying =
these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"706A1",=0A    "new produc=
tion mcu rev":"00000022",=0A    "platfrorm id":"01",=0A    "pre-mitigation =
product mcu":"---",=0A    "product names":"Gemini Lake",=0A    "production =
status":"Production",=0A    "public name":"Intel=C2=AE Pentium=C2=AE Silver=
 processors N5xxx, J5xxx\nIntel=C2=AE Celeron=C2=AE processors N4xxx, J4xxx=
",=0A    "sku_microcode.model":"INTEL_FAM6_ATOM_GEMINI_LAKE",=0A    "sku_mi=
crocode.stepping":"0x01",=0A    "stop deploying these mcu revs":"---"=0A  }=
,=0A  {=0A    "cpuid":"10676",=0A    "new production mcu rev":"---",=0A    =
"platfrorm id":"40",=0A    "pre-mitigation product mcu":"0x60F",=0A    "pro=
duct names":"Harpertown",=0A    "production status":"Planning",=0A    "publ=
ic name":"Intel=C2=AE Xeon=C2=AE Processor X33xx",=0A    "sku_microcode.mod=
el":"INTEL_FAM6_CORE2_PENRYN",=0A    "sku_microcode.stepping":"0x06",=0A   =
 "stop deploying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"1067A",=
=0A    "new production mcu rev":"---",=0A    "platfrorm id":"44",=0A    "pr=
e-mitigation product mcu":"0xA0B",=0A    "product names":"Harpertown, Wolfd=
ale DP",=0A    "production status":"Planning",=0A    "public name":"Intel=
=C2=AE Core=E2=84=A2 2 processor, Intel=C2=AE Pentium=C2=AE Processor E",=
=0A    "sku_microcode.model":"INTEL_FAM6_CORE2_PENRYN",=0A    "sku_microcod=
e.stepping":"0x0A",=0A    "stop deploying these mcu revs":"---"=0A  },=0A  =
{=0A    "cpuid":"306C3",=0A    "new production mcu rev":"---",=0A    "platf=
rorm id":"32",=0A    "pre-mitigation product mcu":"0x23",=0A    "product na=
mes":"Haswell (including H, S)",=0A    "production status":"Pre-Beta",=0A  =
  "public name":"4th Generation Intel=C2=AE Core=E2=84=A2 Mobile Processor =
Family, Intel=C2=AE\nPentium=C2=AE Mobile Processor Family, and Intel=C2=AE=
 Celeron=C2=AE\nMobile Processor Family",=0A    "sku_microcode.model":"INTE=
L_FAM6_HASWELL_CORE",=0A    "sku_microcode.stepping":"0x03",=0A    "stop de=
ploying these mcu revs":"0x23"=0A  },=0A  {=0A    "cpuid":"306C3",=0A    "n=
ew production mcu rev":"---",=0A    "platfrorm id":"32",=0A    "pre-mitigat=
ion product mcu":"0x23",=0A    "product names":"Haswell E3",=0A    "product=
ion status":"Planning",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Process=
or E3-1200 v3 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_HASW=
ELL_CORE",=0A    "sku_microcode.stepping":"0x03",=0A    "stop deploying the=
se mcu revs":"0x23"=0A  },=0A  {=0A    "cpuid":"40661",=0A    "new producti=
on mcu rev":"---",=0A    "platfrorm id":"32",=0A    "pre-mitigation product=
 mcu":"0x17",=0A    "product names":"Haswell Perf Halo",=0A    "production =
status":"Planning",=0A    "public name":"Intel=C2=AE Core=E2=84=A2 Extreme =
Processor (5960x, 5930x, 5820x)",=0A    "sku_microcode.model":"INTEL_FAM6_H=
ASWELL_GT3E",=0A    "sku_microcode.stepping":"0x01",=0A    "stop deploying =
these mcu revs":"0x18"=0A  },=0A  {=0A    "cpuid":"306F2",=0A    "new produ=
ction mcu rev":"---",=0A    "platfrorm id":"6F",=0A    "pre-mitigation prod=
uct mcu":"0x3A",=0A    "product names":"Haswell Server E, EP",=0A    "produ=
ction status":"Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Processor=
 E5v3 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_HASWELL_X",=
=0A    "sku_microcode.stepping":"0x02",=0A    "stop deploying these mcu rev=
s":"0x3B"=0A  },=0A  {=0A    "cpuid":"306F4",=0A    "new production mcu rev=
":"---",=0A    "platfrorm id":"80",=0A    "pre-mitigation product mcu":"0x9=
\n(Windows),\n0xF (Linux)",=0A    "product names":"Haswell Server EX",=0A  =
  "production status":"Pre-Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=
=AE Processor E7v3 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6=
_HASWELL_X",=0A    "sku_microcode.stepping":"0x04",=0A    "stop deploying t=
hese mcu revs":"0x10"=0A  },=0A  {=0A    "cpuid":"40651",=0A    "new produc=
tion mcu rev":"---",=0A    "platfrorm id":"72",=0A    "pre-mitigation produ=
ct mcu":"0x20",=0A    "product names":"Haswell ULT",=0A    "production stat=
us":"Beta",=0A    "public name":"4th Generation Intel=C2=AE Core=E2=84=A2 M=
obile Processor Family, Intel=C2=AE\nPentium=C2=AE Mobile Processor Family,=
 and Intel=C2=AE Celeron=C2=AE\nMobile Processor Family",=0A    "sku_microc=
ode.model":"INTEL_FAM6_HASWELL_ULT",=0A    "sku_microcode.stepping":"0x01",=
=0A    "stop deploying these mcu revs":"0x21"=0A  },=0A  {=0A    "cpuid":"3=
06A9",=0A    "new production mcu rev":"---",=0A    "platfrorm id":"12",=0A =
   "pre-mitigation product mcu":"0x1B\n(Windows),\n0x1C (Linux)",=0A    "pr=
oduct names":"Ivy Bridge",=0A    "production status":"Pre-Beta",=0A    "pub=
lic name":"3rd Generation Intel=C2=AE Core=E2=84=A2 Mobile Processor Family=
, Intel=C2=AE\nPentium=C2=AE Mobile Processor Family, and Intel=C2=AE Celer=
on=C2=AE\nMobile Processor Family",=0A    "sku_microcode.model":"INTEL_FAM6=
_IVYBRIDGE",=0A    "sku_microcode.stepping":"0x09",=0A    "stop deploying t=
hese mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"306A9",=0A    "new product=
ion mcu rev":"---",=0A    "platfrorm id":"12",=0A    "pre-mitigation produc=
t mcu":"0x1B\n(Windows),\n0x1C (Linux)",=0A    "product names":"Ivy Bridge =
E3",=0A    "production status":"Pre-Beta",=0A    "public name":"Intel=C2=AE=
 Xeon=C2=AE Processor E3-1200 v2 Product Family",=0A    "sku_microcode.mode=
l":"INTEL_FAM6_IVYBRIDGE",=0A    "sku_microcode.stepping":"0x09",=0A    "st=
op deploying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"306E4",=0A  =
  "new production mcu rev":"---",=0A    "platfrorm id":"ED",=0A    "pre-mit=
igation product mcu":"0x428",=0A    "product names":"Ivy Bridge Server E, E=
N, EP",=0A    "production status":"Beta",=0A    "public name":"Intel=C2=AE =
Xeon=C2=AE Processor E5v2 Product Family",=0A    "sku_microcode.model":"INT=
EL_FAM6_IVYBRIDGE_X",=0A    "sku_microcode.stepping":"0x04",=0A    "stop de=
ploying these mcu revs":"0x42A"=0A  },=0A  {=0A    "cpuid":"306E7",=0A    "=
new production mcu rev":"---",=0A    "platfrorm id":"ED",=0A    "pre-mitiga=
tion product mcu":"0x70D",=0A    "product names":"Ivy Bridge Server EX",=0A=
    "production status":"Pre-Beta",=0A    "public name":"Intel=C2=AE Xeon=
=C2=AE Processor E7v2 Product Family",=0A    "sku_microcode.model":"INTEL_F=
AM6_IVYBRIDGE_X",=0A    "sku_microcode.stepping":"0x07",=0A    "stop deploy=
ing these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"106E4",=0A    "new pr=
oduction mcu rev":"---",=0A    "platfrorm id":"09",=0A    "pre-mitigation p=
roduct mcu":"---",=0A    "product names":"Jasper (embedded Nehalem)",=0A   =
 "production status":"Planning",=0A    "public name":"Intel=C2=AE Celeron=
=C2=AE Processor P1053\nIntel=C2=AE Xeon=C2=AE Processor ECxxxx, LCxxxx",=
=0A    "sku_microcode.model":"INTEL_FAM6_NEHALEM",=0A    "sku_microcode.ste=
pping":"0x04",=0A    "stop deploying these mcu revs":"---"=0A  },=0A  {=0A =
   "cpuid":"906E9",=0A    "new production mcu rev":"---",=0A    "platfrorm =
id":"2A",=0A    "pre-mitigation product mcu":"0x70",=0A    "product names":=
"Kaby Lake H/S/X/G",=0A    "production status":"Beta",=0A    "public name":=
"7th Generation Intel=C2=AE Core=E2=84=A2 Processor Family",=0A    "sku_mic=
rocode.model":"INTEL_FAM6_KABYLAKE_DESKTOP",=0A    "sku_microcode.stepping"=
:"0x09",=0A    "stop deploying these mcu revs":"0x80"=0A  },=0A  {=0A    "c=
puid":"806EA",=0A    "new production mcu rev":"---",=0A    "platfrorm id":"=
C0",=0A    "pre-mitigation product mcu":"0x70",=0A    "product names":"Kaby=
 Lake Refresh U 4+2",=0A    "production status":"Beta",=0A    "public name"=
:"8th Generation Intel=C2=AE Core=E2=84=A2 Mobile Processor Family",=0A    =
"sku_microcode.model":"INTEL_FAM6_KABYLAKE_MOBILE",=0A    "sku_microcode.st=
epping":"0x0A",=0A    "stop deploying these mcu revs":"0x80"=0A  },=0A  {=
=0A    "cpuid":"806E9",=0A    "new production mcu rev":"---",=0A    "platfr=
orm id":"C0",=0A    "pre-mitigation product mcu":"0x70",=0A    "product nam=
es":"Kaby Lake U/Y, U23e",=0A    "production status":"Beta",=0A    "public =
name":"7th Generation Intel=C2=AE Core=E2=84=A2 Mobile Processors",=0A    "=
sku_microcode.model":"INTEL_FAM6_KABYLAKE_MOBILE",=0A    "sku_microcode.ste=
pping":"0x09",=0A    "stop deploying these mcu revs":"0x80"=0A  },=0A  {=0A=
    "cpuid":"906E9",=0A    "new production mcu rev":"---",=0A    "platfrorm=
 id":"2A",=0A    "pre-mitigation product mcu":"0x70",=0A    "product names"=
:"Kaby Lake Xeon E3, Greenlow",=0A    "production status":"Beta",=0A    "pu=
blic name":"7th Generation Intel=C2=AE Core=E2=84=A2 Processor Family",=0A =
   "sku_microcode.model":"INTEL_FAM6_KABYLAKE_DESKTOP",=0A    "sku_microcod=
e.stepping":"0x09",=0A    "stop deploying these mcu revs":"0x80"=0A  },=0A =
 {=0A    "cpuid":"50671",=0A    "new production mcu rev":"0x1B6",=0A    "pl=
atfrorm id":"78",=0A    "pre-mitigation product mcu":"---",=0A    "product =
names":"Knights Landing",=0A    "production status":"Production",=0A    "pu=
blic name":"Intel=C2=AE Xeon=C2=AE Phi=E2=84=A2 Processor 72xx",=0A    "sku=
_microcode.model":"INTEL_FAM6_XEON_PHI_KNL",=0A    "sku_microcode.stepping"=
:"0x01",=0A    "stop deploying these mcu revs":"---"=0A  },=0A  {=0A    "cp=
uid":"80650",=0A    "new production mcu rev":"0x18",=0A    "platfrorm id":"=
08",=0A    "pre-mitigation product mcu":"---",=0A    "product names":"Knigh=
ts Mill",=0A    "production status":"Production",=0A    "public name":"Inte=
l=C2=AE Xeon=C2=AE Phi=E2=84=A2 Processor Family",=0A    "sku_microcode.mod=
el":"INTEL_FAM6_XEON_PHI_KNM",=0A    "sku_microcode.stepping":"0x00",=0A   =
 "stop deploying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"206E6",=
=0A    "new production mcu rev":"---",=0A    "platfrorm id":"04",=0A    "pr=
e-mitigation product mcu":"0x0B",=0A    "product names":"Nehalem EX",=0A   =
 "production status":"Planning",=0A    "public name":"Intel=C2=AE Xeon=C2=
=AE 65xx, Intel=C2=AE Xeon=C2=AE 75xx",=0A    "sku_microcode.model":"INTEL_=
FAM6_NEHALEM_EX",=0A    "sku_microcode.stepping":"0x06",=0A    "stop deploy=
ing these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"1067A",=0A    "new pr=
oduction mcu rev":"---",=0A    "platfrorm id":"B1",=0A    "pre-mitigation p=
roduct mcu":"0xA0C\n(Windows),\n0xA0B (Linux)",=0A    "product names":"Penr=
yn QC, Wolfdale, Yorkfield",=0A    "production status":"Planning",=0A    "p=
ublic name":"Intel=C2=AE Core=E2=84=A22 Extreme Processor QX9300, QX9650,\n=
QX9770, QX9775, X9000, X9100\nIntel=C2=AE Core=E2=84=A22 Quad Processor Q82=
00, Q8200S, Q8300,\nQ8400, Q8400S, Q9300, Q9400, Q9400S, Q9450, Q9500,\nQ95=
05, Q9505S, Q9550, Q9550S, Q9650, Q9000, Q9100\nIntel=C2=AE Core=E2=84=A22 =
Duo Processor E7200, E7300, E7400, E7500,\nE7600, E8190, E8200, E8300, E840=
0, E8500, E8600, T6400,\nT6500, T6670, T8100, T8300, T9300, T9400, T9500,\n=
T9550, T9600, T9800, T9900, SU9300, SU9400, SU9600,\nSP9300, SP9400, SP9600=
, SL9380, SL9400, SL9600,\nSL9300, P7350, P7370, P7450, P7550, P7570, P8400=
,\nP8600, P8700, P8800, P9500, P9600, P9700\nIntel=C2=AE Core=E2=84=A22 Sol=
o Processor SU3500, ULV SU3500, ULV\nSU3300\nIntel=C2=AE Pentium=C2=AE Proc=
essor E5200, E5300, E5400, E5500,\nE5700, E5800, E6300, E6500, E6500K, E660=
0, E6700,\nE6800, T4200, T4300, T4400, T4500\nIntel=C2=AE Celeron=C2=AE Pro=
cessor 900, 925, E3200, E3300, E3400,\nE3500, SU2300, T3100, T3300, T3500, =
ULV 763\nIntel=C2=AE Celeron=C2=AE M Processor ULV 722, ULV 723, ULV 743",=
=0A    "sku_microcode.model":"INTEL_FAM6_CORE2_PENRYN",=0A    "sku_microcod=
e.stepping":"0x0A",=0A    "stop deploying these mcu revs":"---"=0A  },=0A  =
{=0A    "cpuid":"206A7",=0A    "new production mcu rev":"---",=0A    "platf=
rorm id":"12",=0A    "pre-mitigation product mcu":"0x29",=0A    "product na=
mes":"Sandy Bridge",=0A    "production status":"Pre-Beta",=0A    "public na=
me":"Intel=C2=AE Core=E2=84=A2 i3-21xx/23xx-T/M/E/UE Processor\nIntel=C2=AE=
 Core=E2=84=A2 i5-23xx/24xx/25xx-T/S/M/K Processor\nIntel=C2=AE Core=E2=84=
=A2 i7-2xxx-S/K/M/QM/LE/UE/QE Processor\nIntel=C2=AE Core=E2=84=A2 i7-29xxX=
M Extreme Processor\nIntel=C2=AE Celeron=C2=AE Desktop G4xx, G5xx Processor=
\nIntel=C2=AE Celeron=C2=AE Mobile 8xx, B8xx Processor\nIntel=C2=AE Pentium=
=C2=AE Desktop 350, G6xx, G6xxT, G8xx Processor\nIntel=C2=AE Pentium=C2=AE =
Mobile 9xx, B9xx Processor",=0A    "sku_microcode.model":"INTEL_FAM6_SANDYB=
RIDGE",=0A    "sku_microcode.stepping":"0x07",=0A    "stop deploying these =
mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"206A7",=0A    "new production m=
cu rev":"---",=0A    "platfrorm id":"12",=0A    "pre-mitigation product mcu=
":"0x29",=0A    "product names":"Sandy Bridge E3",=0A    "production status=
":"Pre-Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Processor E3-1200=
 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_SANDYBRIDGE",=0A =
   "sku_microcode.stepping":"0x07",=0A    "stop deploying these mcu revs":"=
---"=0A  },=0A  {=0A    "cpuid":"206D6",=0A    "new production mcu rev":"--=
-",=0A    "platfrorm id":"6D",=0A    "pre-mitigation product mcu":"0x619",=
=0A    "product names":"Sandy Bridge Server\nEN/EP/EP4S",=0A    "production=
 status":"Pre-Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Processor =
E5 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_SANDYBRIDGE_X",=
=0A    "sku_microcode.stepping":"0x06",=0A    "stop deploying these mcu rev=
s":"---"=0A  },=0A  {=0A    "cpuid":"206D7",=0A    "new production mcu rev"=
:"---",=0A    "platfrorm id":"6D",=0A    "pre-mitigation product mcu":"0x71=
0",=0A    "product names":"Sandy Bridge Server\nEN/EP/EP4S",=0A    "product=
ion status":"Pre-Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Process=
or E5 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_SANDYBRIDGE_=
X",=0A    "sku_microcode.stepping":"0x07",=0A    "stop deploying these mcu =
revs":"---"=0A  },=0A  {=0A    "cpuid":"50654",=0A    "new production mcu r=
ev":"---",=0A    "platfrorm id":"B7",=0A    "pre-mitigation product mcu":"0=
x2000035",=0A    "product names":"Skylake D, Bakerville",=0A    "production=
 status":"Beta",=0A    "public name":"Intel=C2=AE Xeon=C2=AE D-2100 process=
or",=0A    "sku_microcode.model":"INTEL_FAM6_SKYLAKE_X",=0A    "sku_microco=
de.stepping":"0x04",=0A    "stop deploying these mcu revs":"0x200003A,\n0x2=
00003C"=0A  },=0A  {=0A    "cpuid":"506E3",=0A    "new production mcu rev":=
"---",=0A    "platfrorm id":"36",=0A    "pre-mitigation product mcu":"0xBA"=
,=0A    "product names":"Skylake E3",=0A    "production status":"Beta",=0A =
   "public name":"Intel=C2=AE Xeon=C2=AE Processor E3-1200 v5 Product Famil=
y",=0A    "sku_microcode.model":"INTEL_FAM6_SKYLAKE_DESKTOP",=0A    "sku_mi=
crocode.stepping":"0x03",=0A    "stop deploying these mcu revs":"---***"=0A=
  },=0A  {=0A    "cpuid":"506E3",=0A    "new production mcu rev":"0xC2***",=
=0A    "platfrorm id":"36",=0A    "pre-mitigation product mcu":"---",=0A   =
 "product names":"Skylake H/S",=0A    "production status":"Production",=0A =
   "public name":"6th Generation Intel=C2=AE Core=E2=84=A2 Processor Family=
",=0A    "sku_microcode.model":"INTEL_FAM6_SKYLAKE_DESKTOP",=0A    "sku_mic=
rocode.stepping":"0x03",=0A    "stop deploying these mcu revs":"---***"=0A =
 },=0A  {=0A    "cpuid":"50654",=0A    "new production mcu rev":"---",=0A  =
  "platfrorm id":"B7",=0A    "pre-mitigation product mcu":"0x2000035",=0A  =
  "product names":"Skylake Server",=0A    "production status":"Beta",=0A   =
 "public name":"Intel=C2=AE Xeon=C2=AE Scalable Processor Family",=0A    "s=
ku_microcode.model":"INTEL_FAM6_SKYLAKE_X",=0A    "sku_microcode.stepping":=
"0x04",=0A    "stop deploying these mcu revs":"0x200003A\n0x200003C,"=0A  }=
,=0A  {=0A    "cpuid":"406E3",=0A    "new production mcu rev":"0xC2***",=0A=
    "platfrorm id":"C0",=0A    "pre-mitigation product mcu":"---",=0A    "p=
roduct names":"Skylake U/Y",=0A    "production status":"Production",=0A    =
"public name":"6th Generation Intel=C2=AE Core=E2=84=A2 m Processors",=0A  =
  "sku_microcode.model":"INTEL_FAM6_SKYLAKE_MOBILE",=0A    "sku_microcode.s=
tepping":"0x03",=0A    "stop deploying these mcu revs":"---***"=0A  },=0A  =
{=0A    "cpuid":"406E3",=0A    "new production mcu rev":"0xC2***",=0A    "p=
latfrorm id":"C0",=0A    "pre-mitigation product mcu":"---",=0A    "product=
 names":"Skylake U23e",=0A    "production status":"Production",=0A    "publ=
ic name":"6th Generation Intel=C2=AE Core=E2=84=A2 m Processors",=0A    "sk=
u_microcode.model":"INTEL_FAM6_SKYLAKE_MOBILE",=0A    "sku_microcode.steppi=
ng":"0x03",=0A    "stop deploying these mcu revs":"---***"=0A  },=0A  {=0A =
   "cpuid":"50654",=0A    "new production mcu rev":"---",=0A    "platfrorm =
id":"B7",=0A    "pre-mitigation product mcu":"0x200002E",=0A    "product na=
mes":"Skylake X, Basin Falls",=0A    "production status":"Beta",=0A    "pub=
lic name":"Intel=C2=AE Core=E2=84=A2 i9 79xxX, 78xxX",=0A    "sku_microcode=
=2Emodel":"INTEL_FAM6_SKYLAKE_X",=0A    "sku_microcode.stepping":"0x04",=0A=
    "stop deploying these mcu revs":"0x200003A\n0x200003C,"=0A  },=0A  {=0A=
    "cpuid":"506D1",=0A    "new production mcu rev":"00000103",=0A    "plat=
frorm id":"02",=0A    "pre-mitigation product mcu":"---",=0A    "product na=
mes":"SoFIA 3G ES2.1 and Granite 4",=0A    "production status":"Production"=
,=0A    "public name":"Intel=C2=AE Atom=C2=AE x3-C3130 Processor",=0A    "s=
ku_microcode.model":"0x5D",=0A    "sku_microcode.stepping":"0x01",=0A    "s=
top deploying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"506D1",=0A =
   "new production mcu rev":"---",=0A    "platfrorm id":"02",=0A    "pre-mi=
tigation product mcu":"---",=0A    "product names":"SoFIA 3GR",=0A    "prod=
uction status":"Planning",=0A    "public name":"Intel=C2=AE Atom=C2=AE x3-C=
3230RK Processor\nIntel=C2=AE Atom=C2=AE x3-C3200RK Processor",=0A    "sku_=
microcode.model":"0x5D",=0A    "sku_microcode.stepping":"0x01",=0A    "stop=
 deploying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"406A8",=0A    =
"new production mcu rev":"00000831",=0A    "platfrorm id":"01",=0A    "pre-=
mitigation product mcu":"---",=0A    "product names":"Tangier (SLM)",=0A   =
 "production status":"Production",=0A    "public name":"Intel=C2=AE Atom=C2=
=AE Processor Z34XX",=0A    "sku_microcode.model":"INTEL_FAM6_ATOM_MERRIFIE=
LD",=0A    "sku_microcode.stepping":"0x08",=0A    "stop deploying these mcu=
 revs":"---"=0A  },=0A  {=0A    "cpuid":"406A9",=0A    "new production mcu =
rev":"00000831",=0A    "platfrorm id":"01",=0A    "pre-mitigation product m=
cu":"---",=0A    "product names":"Tangier (SLM)",=0A    "production status"=
:"Production",=0A    "public name":"Intel=C2=AE Atom=C2=AE Processor Z34XX"=
,=0A    "sku_microcode.model":"INTEL_FAM6_ATOM_MERRIFIELD",=0A    "sku_micr=
ocode.stepping":"0x09",=0A    "stop deploying these mcu revs":"---"=0A  },=
=0A  {=0A    "cpuid":"30679",=0A    "new production mcu rev":"0000090A",=0A=
    "platfrorm id":"0C",=0A    "pre-mitigation product mcu":"---",=0A    "p=
roduct names":"Valleyview, Baytrail M/D/I D0, D1",=0A    "production status=
":"Production",=0A    "public name":"Intel=C2=AE Atom=C2=AE Processor E3800=
 Product Family\nIntel=C2=AE Celeron=C2=AE Processor N2807, N2930\nIntel=C2=
=AE Pentium=C2=AE Processor J1800, J1900",=0A    "sku_microcode.model":"INT=
EL_FAM6_ATOM_SILVERMONT1",=0A    "sku_microcode.stepping":"0x09",=0A    "st=
op deploying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"30678",=0A  =
  "new production mcu rev":"00000836",=0A    "platfrorm id":"02",=0A    "pr=
e-mitigation product mcu":"---",=0A    "product names":"Valleyview, Baytrai=
l M/D/T C0",=0A    "production status":"Production",=0A    "public name":"I=
ntel=C2=AE Celeron=C2=AE Processor Nxxxx\nIntel=C2=AE Pentium=C2=AE Process=
or Jxxxx\nIntel=C2=AE Atom=C2=AE Processor Z3740D\nIntel=C2=AE Pentium=C2=
=AE Processor J2900",=0A    "sku_microcode.model":"INTEL_FAM6_ATOM_SILVERMO=
NT1",=0A    "sku_microcode.stepping":"0x08",=0A    "stop deploying these mc=
u revs":"---"=0A  },=0A  {=0A    "cpuid":"30673",=0A    "new production mcu=
 rev":"0000326",=0A    "platfrorm id":"01",=0A    "pre-mitigation product m=
cu":"---",=0A    "product names":"Valleyview, Baytrail M/D/T/I B2,\nB3",=0A=
    "production status":"Production",=0A    "public name":"Intel=C2=AE Cele=
ron=C2=AE Processor Nxxxx\nIntel=C2=AE Pentium=C2=AE Processor Jxxxx\nIntel=
=C2=AE Atom=C2=AE Processor Z3740D",=0A    "sku_microcode.model":"INTEL_FAM=
6_ATOM_SILVERMONT1",=0A    "sku_microcode.stepping":"0x03",=0A    "stop dep=
loying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"206F2",=0A    "new=
 production mcu rev":"---",=0A    "platfrorm id":"05",=0A    "pre-mitigatio=
n product mcu":"0x37",=0A    "product names":"Westmere EX (EGL, WSM)",=0A  =
  "production status":"Planning",=0A    "public name":"Intel=C2=AE Xeon=C2=
=AE Processor E7 Product Family",=0A    "sku_microcode.model":"INTEL_FAM6_W=
ESTMERE_EX",=0A    "sku_microcode.stepping":"0x02",=0A    "stop deploying t=
hese mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"206C2",=0A    "new product=
ion mcu rev":"---",=0A    "platfrorm id":"03",=0A    "pre-mitigation produc=
t mcu":"0xF",=0A    "product names":"Westmere WS, Westmere EP,\nGulftown",=
=0A    "production status":"Planning",=0A    "public name":"Legacy Intel=C2=
=AE Xeon=C2=AE Processor 5600 Product Family, W36xx\nIntel=C2=AE Core=E2=84=
=A2 i7-970, 980\nIntel=C2=AE Core=E2=84=A2 Processor Extreme Edition i7-980=
X, 990X",=0A    "sku_microcode.model":"INTEL_FAM6_WESTMERE_EP",=0A    "sku_=
microcode.stepping":"0x02",=0A    "stop deploying these mcu revs":"---"=0A =
 },=0A  {=0A    "cpuid":"10676",=0A    "new production mcu rev":"---",=0A  =
  "platfrorm id":"04",=0A    "pre-mitigation product mcu":"0x60F",=0A    "p=
roduct names":"Wolfdale DP",=0A    "production status":"Planning",=0A    "p=
ublic name":"Intel=C2=AE Xeon=C2=AE 5200 Family",=0A    "sku_microcode.mode=
l":"INTEL_FAM6_CORE2_PENRYN",=0A    "sku_microcode.stepping":"0x06",=0A    =
"stop deploying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"10676",=
=0A    "new production mcu rev":"---",=0A    "platfrorm id":"91",=0A    "pr=
e-mitigation product mcu":"0x610\n(Windows),\n0x60F (Linux)",=0A    "produc=
t names":"Wolfdale, Wolfdale Xeon,\nYorkfield Xeon",=0A    "production stat=
us":"Planning",=0A    "public name":"Intel=C2=AE Xeon=C2=AE Processor X, E,=
 L",=0A    "sku_microcode.model":"INTEL_FAM6_CORE2_PENRYN",=0A    "sku_micr=
ocode.stepping":"0x06",=0A    "stop deploying these mcu revs":"---"=0A  },=
=0A  {=0A    "cpuid":"1067A",=0A    "new production mcu rev":"---",=0A    "=
platfrorm id":"44",=0A    "pre-mitigation product mcu":"0xA0B",=0A    "prod=
uct names":"Wolfdale, Wolfdale Xeon,\nYorkfield, Yorkfield Xeon",=0A    "pr=
oduction status":"Planning",=0A    "public name":"Intel=C2=AE Celeron=C2=AE=
 Desktop E3xxx Processor\nIntel=C2=AE Core=E2=84=A22 Duo E7xxx, E8xxx Proce=
ssor\nIntel=C2=AE Pentium=C2=AE E5xxx, E6xxx, E6xxxK Processor\nIntel=C2=AE=
 Core=E2=84=A22 Quad Q9xxx, Q8xxx, Q9xxxS Processor\nIntel=C2=AE Core=E2=84=
=A2 Extreme QX9xxx Processor",=0A    "sku_microcode.model":"INTEL_FAM6_CORE=
2_PENRYN",=0A    "sku_microcode.stepping":"0x0A",=0A    "stop deploying the=
se mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"60650",=0A    "new productio=
n mcu rev":"00000015",=0A    "platfrorm id":"01",=0A    "pre-mitigation pro=
duct mcu":"---",=0A    "product names":"XGold 7272",=0A    "production stat=
us":"Production",=0A    "public name":"Intel=C2=AE XMM=E2=84=A2 7272 Modem"=
,=0A    "sku_microcode.model":"0x65",=0A    "sku_microcode.stepping":"0x00"=
,=0A    "stop deploying these mcu revs":"---"=0A  },=0A  {=0A    "cpuid":"1=
0677",=0A    "new production mcu rev":"---\n",=0A    "platfrorm id":"10",=
=0A    "pre-mitigation product mcu":"0x70B\n(Windows),\n0x70A (Linux)",=0A =
   "product names":"Yorkfield, XE, Xeon",=0A    "production status":"Planni=
ng",=0A    "public name":"Intel=C2=AE Core=E2=84=A22 Extreme Processor, Int=
el=C2=AE Core=E2=84=A22 Quad\nProcessor",=0A    "sku_microcode.model":"INTE=
L_FAM6_CORE2_PENRYN",=0A    "sku_microcode.stepping":"0x07",=0A    "stop de=
ploying these mcu revs":"---"=0A  }=0A]=0A
--BXVAT5kNtrzKuDFl--
