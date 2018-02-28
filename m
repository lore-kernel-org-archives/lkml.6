Return-Path: <avagin@virtuozzo.com>
X-Google-Smtp-Source: AH8x227jzl0Ki+8FKVtl8sOzmicS34J8/Lw9SDpHKWojX5twDMjfX5vcDMC/YZ0rbVKVNSEEVmWf
ARC-Seal: i=1; a=rsa-sha256; t=1519840251; cv=none;
        d=google.com; s=arc-20160816;
        b=jnmV+o32v+TkvntcfBftbe/8dT6Mf97TeHNqXVYV+FjipR2JAiK6WKr5zQvBc/k4SM
         FBe6PzeACeFOwyfiSgF5527IRwzGRN0eetJaOruPJozSmffd5513OvN3acC+WHL1DguJ
         LX8sK0L5ifY2UaH2xJRJ+utnYpzGtQuBMT11vugJUV6+bdxiTRoqalCtBpyXq2yrVIG2
         GO9ufgAsSKyCTAa5NXBC5nysGs0IcE6n8B9JWXombXgjtbxv3SrNrrqundbhrnHk+iUc
         Bw5yn2GPaFmXrVCnjL8XbhuxnDsZkmu5KaLhFNQtfa8Yn+T/o5AZ5A4nRZh9ffpd6OYr
         qSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=B84sfxaZoVFX+9utguQ2qBWVGYiN/yFJvEBQPo1JSzw=;
        b=vO5MXjgFNn3+TvhMt1vDL0PDes7sCj5mljYzb3tTevHcqL91tOoab7STPC8h3DbRPU
         GICfui/W0JzpvPklBf3bUHHYg8voIutoPaE8LdkfsuJ+k3Cb4XTJJlxTb1ULJMz3POoK
         q0J9g+3DbdfGOB9gEhRuW7yesONv8/pprn10QX6cKHC+ClSJh9mdkRa3At/OTZzelsRe
         WMOKUcxiVY/HCipnA7o60/OLuuewx7SFfGibCazkag/Eq9y+vP1bmy7yUcdXMFjB81cv
         qlknWQXe2ybJ3WL8n4y8/JMiWyg8c1GwNnSBZOQ9/tRJfUnR+vVv5r57dvIx2jGz2OL1
         OZIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=UmrElVzo;
       spf=pass (google.com: domain of avagin@virtuozzo.com designates 40.107.4.131 as permitted sender) smtp.mailfrom=avagin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=UmrElVzo;
       spf=pass (google.com: domain of avagin@virtuozzo.com designates 40.107.4.131 as permitted sender) smtp.mailfrom=avagin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Wed, 28 Feb 2018 09:50:36 -0800
From: Andrei Vagin <avagin@virtuozzo.com>
To: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, criu@openvz.org, gdb@sourceware.org,
	devel@lists.open-mpi.org, rr-dev@mozilla.org,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>, Jann Horn <jannh@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCH v5 0/4] vm: add a syscall to map a process memory into a
 pipe
Message-ID: <20180228175035.GA20686@outlook.office365.com>
References: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
 <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
 <20180227021818.GA31386@altlinux.org>
 <627ac4f8-a52d-0582-0c9e-e70ea667fa7e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <627ac4f8-a52d-0582-0c9e-e70ea667fa7e@virtuozzo.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: HE1PR1001CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::15) To AM4PR08MB0739.eurprd08.prod.outlook.com
 (2a01:111:e400:59ed::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5437d48-1d10-499d-f99b-08d57ed3cc9b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR08MB0739;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0739;3:/1L9iSP5T0LamtTRDSB8JeocE0cZs8xoxjME2I/YZKb1roIXJf4mYztzw6fyWMIz7FdZSQDDY88CIbGrCUnFGhfSnbTHVIVLKYPKsqisxjTWjlzAcGLt8jLnZLSE7SkWAFaadNUxTtvdDC3YDFuZQuaJSgZdZmkfFJJ3jMJkjma92woq7yNU18LswsNIqH/EJGvqFvNTppOpRTw8nCLp1jvgCziYAj4JYI6BWunN+m64LSjK8wmBn2VecCJOF5be;25:M+lw2U+wtThZi5u0k++6ES4JdmQe+iaARliq6teQXUG7AqpV0QwFEoNpxW4NEsNaqgr8YOmAVOI90VpCNnOfqfgnwuPXZ57gP3a8m89SkJz0O3Bo07xhJKChzEy0mZe/XJrBihx9L4FWmigVYpWaYKYqsRxJqyjO1bslGLHDtrMF+mS+i8hhN+Ytgz4GInLhXyMi5Wssg/49Iymq0XIgX/u4jwaxXivWoHJgXVrIxjAmEHa8NrkdJEmr0i359MBMHsaZSDVye70yGI+wU81DIK4iN2gj3Dh9Vt/F1lQRryXPdpe9kjcAYiX/+clyG8a68lRmd1mhX4Q2XxkvVLyr8g==;31:diT+tW4Vk4CBBba3cm9c5m1zNewE8xzPcf4+w7f7ucC8PNWsVoDh22hwByOaqzUB3c1/p5e+S4cvAmY5Mo5QujCV5V6ogkNFcoI4V3dGxJCviJnXKBE91ZNPBYKOAbbngg8MOSY0fglws2m8LgQVFdzzB1QPQ6uikj5yBRbtYsp7XQRt82UvbxWZSlhsQDzMjzb1Ln1QyLqjey0nZCOZxTf0E261xiJ5wPOtEWAJxoQ=
X-MS-TrafficTypeDiagnostic: AM4PR08MB0739:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0739;20:FQ8NFxP0ymbemlasP/hKZjnNzdTo7oEMrZeNk7s3l8XhBDBpxht8QquZZvI6RMzrK1lNTwxwtMpp58HBcTK/ALEn7RbLvjRb8QqMltopFqme8YaeqOo7dOvSBqiO+T7oYrwhW3slW8jmAEnWER7RyhK+zka6cC9GFLz9HnweL9gnYhMpw/Dm3r0lnhP+M10iyOD0fKd4Ll/uq7XBCqg5QRDDll1Cnt+1cC/cX7forGh+PJqGvBhSXiOjD8yT/DlsYD7HnxLdevn8F2GrEsDfXNyxIuSKwrwx/j4gOvyyFq8kXKxDmDj6u3wl0O8pcPB0MxQGIIXpSYueO+6GZEBxsf7h7u2e1P92l9MP2M3Ph+YLEEB2RCrnEUyiBUtW0ZMSJ0ODlaVk1QtzFm5sVqRVz4hC2VKulV6AhsU+81dgvaiFYsY0tsRVmPNuMjlekGOcnIrqDGRGEWiWFligxLuwO8nqGkvsymhZDgQevH3mBo7eT2rAmh9/H0H43UTDhEdh;4:2PWYamVtHWduTllNfxNm2Ra3gyVwwjL1NDrgY5KbSMmLfA+bZn+qrRocaSL+jgwIuWefxbyhZVc1WfNwqJN7LtADrPGvVSLrShuPuv8m49US6GrMjpZT/7RStImcV5RATeTf73kzDV7+ewrU9WyqDZr/29Fmk73kODXYM910DCYmfXyBly/fD2NL5cpVqRgRqJ1A540/Boo00R+fkXf+SjjS+qM2/7jXfHwjQyz7Mtk+2rUUJPGwRAhmKZNrUwtixGZYkUzX43QhgutRbnh7cqjLRZJcfj3UsJXRU5hd5TIjIucqL1RmlZc7H7WYwDnT
X-Microsoft-Antispam-PRVS: <AM4PR08MB07391CC461B0E6DDDE867987CFC70@AM4PR08MB0739.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501217)(52105095)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR08MB0739;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB0739;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39850400004)(396003)(346002)(376002)(189003)(199004)(68736007)(2950100002)(16586007)(50466002)(39060400002)(6862004)(5890100001)(229853002)(54906003)(105586002)(6246003)(23686003)(37156001)(25786009)(97736004)(58126008)(4326008)(2906002)(107886003)(93886005)(55016002)(386003)(69596002)(76176011)(8936002)(8676002)(66066001)(3846002)(7696005)(53546011)(6506007)(26005)(1076002)(81156014)(33656002)(52116002)(7736002)(6666003)(81166006)(53416004)(47776003)(305945005)(6636002)(9686003)(7416002)(53936002)(316002)(478600001)(86362001)(106356001)(5660300001)(16526019)(6116002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB0739;H:outlook.office365.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM4PR08MB0739;23:zqtnJCVmEjGan8zhaNz6VWMlH93/Hiamoz2S32T8DCq?=
 =?koi8-r?Q?RCBxvs5NJoGe8OYN5aQ474mDTj6zMrlB1Etx8A8kQDUKBWlN22d6DS4iA6Uq+f?=
 =?koi8-r?Q?33yFf/fEheMc08OzkF9Pn6rYVKSqgHUWgOKgxPA+C/mi/6vmaMNG1GpfLz5OYx?=
 =?koi8-r?Q?O/642sd8L3txwpsekvuAyoWhqH7I6fugvroJ4FwDOLst1hWu++rFMqq0xul2JW?=
 =?koi8-r?Q?Pe2NNkukKmQ2mhUxcTd76Vq0bifUAzX9hhhM93IYiDtGICz50nztHX4x4mXJAz?=
 =?koi8-r?Q?lUw9kObQQeGaRFjfrLhoiRJasDeGbddYqjuAZ6nFKc6LvKbiyzMuZI3nFkrALJ?=
 =?koi8-r?Q?Rm8+X2FMACP6CRB0TEFWEQYiZW6gL/KnCRiZ+yBiIeuiRusWFqdmv0Q9C4TOnU?=
 =?koi8-r?Q?iPB/S1v3cDOk/4iKGii239yVpV+7Rul2s1Zu3B+aJhEW3op74vS2HNW4hzUik2?=
 =?koi8-r?Q?KPXOwRRhvqIJsK35QpO8WQd8fEhkYiQ4sOaHTuXfntVsJUSiERX9eD7Qn9vCXv?=
 =?koi8-r?Q?+3BU+LEJVeMCxeBsqpVBvEp1JMu1wJhVTaofJl8YVCkerlDiubl36deEIz9lui?=
 =?koi8-r?Q?F0v0xUHLsW1QWUrzymaVVrMUijMwqqpseCoKbOlPmsKy67dxm3rsvQxGwfNa5Q?=
 =?koi8-r?Q?IHIInEUIkw0NGZqzagOLYkJkeXaq4c58ssZM07vcPZ3tEJ6y3yFWqWM8c4WH7R?=
 =?koi8-r?Q?Y/hRlJcs20lkUWcoNxgtF6va4GhtdFqCo9stmbGwB8IsQva/TJpwCSoqlHb9LG?=
 =?koi8-r?Q?82fqkebyXvf+FzeS/YH+D4hcU5wjkO7rerS5TKWx5jSDJaBCS5CJfj3MwtnEWe?=
 =?koi8-r?Q?qADgRV0Lqg52FSvp6eheD2Iw0o5jIMndOGnWqzTF6QaysDK3ds68C6DSRkeKQR?=
 =?koi8-r?Q?eWUVNDJ7IKgzsOq54N62URRyz3N5xMqb0ScFth8a6hjf/r5ov7xnJHmq491KYt?=
 =?koi8-r?Q?d1/fSO1stRLWAm3v7f6z8C5bp2GTL+2TJRgOUUeiE/P8qyTG2QANgUasPkFj+c?=
 =?koi8-r?Q?uL37ng6glSk3yQBgjOuj9fajJhAVJ3Wld9J8gQYjCxGfUOrYe6Vd0vY0Xh2N5a?=
 =?koi8-r?Q?6tIfwPdVuzGJ3B3J8OIF0TCwmGRICXVeBzb9Wjlf1w3AC3edkUiB90X/fmCn1i?=
 =?koi8-r?Q?w4aNKpffXa/0jS5a8UaoPEdXICkDOjzJrVPe47if0CcPQFKJNhyhPq2YKdRiDG?=
 =?koi8-r?Q?QxFbrTLCMVRl5q6xBHRvbBgIxDPiJelxbpklka4ZLE04hs9jneGwdiifxPfjXh?=
 =?koi8-r?Q?DI/waXB8lKYCuyIeW7et03LPJb2UNdvPCiVh0FQ030Uga1MTd7CeTi1lDUXsmd?=
 =?koi8-r?Q?OG0JDkcmgMrrzZU5BDYKQBMU2RlBWSCEr/AIZlWBSFt+OKJ5ebtb9AegB0b6Wj?=
 =?koi8-r?Q?YIeGObQE5TVq6nAcVvkDlmQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0739;6:PwaJ0jMW33L7Twyhv/POfnhFQR588opYQFcs2wfvL/HyJ0jwzDrDWalwKEtQy10dJad+0xsuAGdPz0uDMehUDZD9gz8bQpAjyPMhWxzxXPE2cOhw3VhHeHmUQtCujSp/CFRXx902ESJqTg/oILD5J3NZwVRRBmWOq2A1CbxmEsJ4HBXb1PxUKpq9K6c6Yy3H6+NSJ2pCdNiQWbj5ZgGJCABhQDS5t1qj5IIEK8tlzTG+Nsev89LU5gFDsZyHPeStVmCAVUS2PD4vy6/bH/ffzFcu5g0xOr94ugbKaLllhELPWt+OwFn8b1GhyGqyssd7SyL6AIKV7k7ja2XR0qUiHjUODNrE7s1xK4H+jZF3kc4=;5:7K4QEFrPx87ZC0bd/4TNBaFI0fSn3qCcWLDoWfOvNYKMcL/k2Gc8/zBU+0SH2X/sp0nyA/TsIQFxTHxmqDxfKrEvcCmfPhPcjHT5fYdsKQSnOGHo9NiGpe2P/5ufXIwtkjRhwTzvML8KrO65/HA6IE2NDgsyaiK/d3Z2oMnLnus=;24:nSqjAmsQUfT+QfiCXnKObynnVwyv8jEqV8F4h4cJJW5yEuIlVjVUk+RuMHPJPXmdi3SGZXyRg7EBC1KTbWc4yzHnZIW8ODYzGjYcNfA8esM=;7:ID3yIr11ftyQuuo3MuqLE5sxcqbXqQA9BXXbpP15CXMILEGs/SkwRGC0vY1rNwoHDOtCSBwuBkueJdRvKVFTjClY7WukqJDHdBX+2WlVKeZqbo1eb6yUvYpbXFR0jc/NH9klL0b/EF2SzoAb3sYKmcdgiUoyCFuCUHW6EBTB8qcmx1n/kOQ4x5COymTxD1Q/CbaneQeD5ggYYkBoffrkQ97Pe3W10aKOvlXTZUiAgjsFVU4CbpoRYIKCIoSnm++C
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0739;20:gNfrPDNJ8qZ687HQL5o/jH/mWMxjRF7UN/NzETDn5Rz7YLX0cb5yZ2sgKBd3mJfErR+l2ag4CF34LhDhdL0KmLEfR4Y5HQp9E+5MgYgOWV8bDAPHc/cQTy2ZHehO11Lo+fPsyDHR16Wlb/t6DljBG6sHOe/n4u3l/gEg4V+tDyM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 17:50:42.3921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5437d48-1d10-499d-f99b-08d57ed3cc9b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0739
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589095397169234429?=
X-GMAIL-MSGID: =?utf-8?q?1593668011696495475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:12:55AM +0300, Pavel Emelyanov wrote:
> On 02/27/2018 05:18 AM, Dmitry V. Levin wrote:
> > On Mon, Feb 26, 2018 at 12:02:25PM +0300, Pavel Emelyanov wrote:
> >> On 02/21/2018 03:44 AM, Andrew Morton wrote:
> >>> On Tue,  9 Jan 2018 08:30:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >>>
> >>>> This patches introduces new process_vmsplice system call that combines
> >>>> functionality of process_vm_read and vmsplice.
> >>>
> >>> All seems fairly strightforward.  The big question is: do we know that
> >>> people will actually use this, and get sufficient value from it to
> >>> justify its addition?
> >>
> >> Yes, that's what bothers us a lot too :) I've tried to start with finding out if anyone 
> >> used the sys_read/write_process_vm() calls, but failed :( Does anybody know how popular
> >> these syscalls are?
> > 
> > Well, process_vm_readv itself is quite popular, it's used by debuggers nowadays,
> > see e.g.
> > $ strace -qq -esignal=none -eprocess_vm_readv strace -qq -o/dev/null cat /dev/null
> 
> I see. Well, yes, this use-case will not benefit much from remote splice. How about more
> interactive debug by, say, gdb? It may attach, then splice all the memory, then analyze
> the victim code/data w/o copying it to its address space?

Hmm, in this case, you probably will want to be able to map pipe pages
into memory.

> 
> -- Pavel
