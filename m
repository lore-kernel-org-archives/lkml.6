Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx4+GCM5bSh6T6Zpen6HoUwfHmE3CVgdHbtCA767rp/mTU+9Mp8BfGbT2W+2C0qZgbBYMNZor
ARC-Seal: i=1; a=rsa-sha256; t=1524112482; cv=none;
        d=google.com; s=arc-20160816;
        b=X/fNHcZeXtY97przj9mwLHDjh67wL4HJN/hsygIQX/Ze6miWjaHdWB0ertqnk+WCSr
         Pd01dJ5c/4U+9VJ3CWzjA13xzE4EpI/+SzRWpmty1SgmjTajlswK04ftWjdc4wNFEWPB
         TVYY+lZrWIzGKkizLnZ8OS0h4fzWG9gaW2t5jnvja2nJpg0VaNv5WzrOKhXMg8T+v1xd
         vkrVE9NoRLfZCnlMewKOjPJpu4KEfFld1YzESFVqr1RAHaAPbpBRsMDT0pdPMbXGRb0F
         5jDloPVQt4bSZtoX1YpmezCC1lu3LssOxLlPfSVVhCKhZykIm8NWvyJb8tWlIN9B7Ejz
         zzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=BDu7szufHSWn+KyODx7KwKM4AOkIwYq7gXg4agfd3Nc=;
        b=SToFGF2t3C6HDYx9afwcoYfKgNfINDD2PtqDInTa50JHhtVm3j8asfAvh47ci3gLJW
         iitEhdfHtt7pldDJ+iTp7UdeGC/8Gay5V1oSqv/waLaNHBFCrR530+toKyas82u00UPt
         COmy8NVEkiEgznm8Jxdlc3QOdE7e6WomfRmVudXeYuTzX80UsM6GaPwR0tMHjcDojnwe
         v+9AzPLZtpAc66fppBJnyh74/TNBZiXkHyHKy4jsb+WaPMgY8QfuuZvldEtPCxdxrkit
         V9ozDR6vPYvobrLCdyWdCkHDgCbHzQI479y5PuHUBvq+3jkO8WAMWXXDDZAvWLBkThPt
         i8jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=U6pjPYGH;
       spf=neutral (google.com: 104.47.36.63 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=U6pjPYGH;
       spf=neutral (google.com: 104.47.36.63 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Subject: Re: [PATCH v2 2/3] ASoC: amd: dma driver changes for BT I2S instance
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
 Akshu Agrawal <akshu.agrawal@amd.com>, jclinton@chromium.org,
 Guenter Roeck <linux@roeck-us.net>, kuninori.morimoto.gx@renesas.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524049494-19526-3-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omBzuC75-pbROzwhQ9WqPQpKywZKEYMYGhdjvDNdZu2j=Q@mail.gmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <371ba4c4-2917-4250-31ed-8da121d1409f@amd.com>
Date: Thu, 19 Apr 2018 10:07:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omBzuC75-pbROzwhQ9WqPQpKywZKEYMYGhdjvDNdZu2j=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::21) To DM2PR12MB0315.namprd12.prod.outlook.com
 (2a01:111:e400:50d0::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0315;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;3:tPuvVLSFEXorAIPR34BM8Zt26o2dAz27Gsp0+TrZfLCszdvD17uaP7tL/XH1U7sHlkl0MK6pOMpyUkLqNYIpwJJrHxwVEUMUY7WF5cOeZoNUDXV11lmzOpPBofK9h6d7jCOfJ8/R4xbNyEGbTjiLkbMbY4nzRinev6Mn4GX0X6s06zjGcXkXMZjHu+lxPU/BsOAQhJS/1ymd51zr367/s3pnXFbqPVmWvAXo82i69I5p6c5WWtMjtjeTD6n04ub/;25:Qsw3PV6Kp0YESTCZ0c7FOcY1TaKiGTFBv7AgQZukt71QSiiv1upybzWDL1afSUkiYDuV54/D5Dz6/HqBQGCHQSk5OEd890HzEXI7IPqjYvTf/uiKpuyJ8Kd5UHdR1YQjObSJkXRz8VYT9qQ2X0eKsovHrAofOBHyGlsE7gzt2/CYDdurFdGb4HRkkrYA84WhNDrhASCOysAosyxa5ugR77mUEZeoH7dB8aiqkOE3TJCeTZcxkTEGI0dR7sB3Z4HsisBIVD/m3olTS8juphm7KqknkIOAbC8WL6Le08CWPiq5Q2MeDr2CpS59EhZfXGeGEfUEEg/zFWPxT85J5NpU4g==;31:gyIbDFTN0Fynn0ELQpCtfRLOWIcfELNlTR1JAWz30N3u6/qjG6E+s0x8pxQTkV8CKbUFCwT6TgY7+TJOOYAeSq/G91U2FzQLoDoWq2JX/jzyZKi8nVc8VW8HTmt3jvGU9IwhUBAlE3n1ciEMgZQ8bGm00UkN5f+85f8gRCuH+QUJ+vq6E3XKE91NpFjk7wRdgNQFBUm0zdgEGIgxJ1jf1J0qwGS4kssaJhmOBXP5Mz0=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0315:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;20:MYUylP7BvyPB9PfSwgHNYm+defh2SPko3Efc+z9ErCylSsFE/Kx20tn/HfA1dStzG2pIfXmcZnaXcf/P41RuISr4vkcvDAfdAl+rssvRh/ZC1tih6EV1nZzmXP7Ovm7P0Cy1Ke93HKp7CmJhih93FC8xEFsgqUC0xhiiqfDGl+1VJpEE9GqAnF+5rNK1nEAdQKGHpNcxSPewqxeXNsNuFMmDoi7xnJWzqmuYusBVetyBu7CGtws4Eo/LSKhN/H+d3CwBjgm3B9zCVX/SgSbljybWPoE4BaA2bxfe1gfEAZjSG45h9VlAZIOEpzHflLnwIYvqxTQc4D+Mx7YzfAjY67vKAeEp3Gp+hi6LJHaNS4sbPeHL2Ntxtzf9oJ6BBTS9ZtMafL1hWJoy8EAz8ekyyXnUZJ0qSl/W4VY/LHgHff2b5YY6q4BMZmr3C4M3KXcctGBLO5slRmExQC0tOiAKwsqq5DXj+CfzqRrwsmUI8jKNhvDpOt4AvNt3TCA00ire;4:G3ZDuLuyj/oXrb7GUYVa+zvNiHhtLNYsUAvS7FisyowEGG4+1H5XdDIyzbT+83kJ19zRMN7iBZ4nttg27tDpXnNGCkyOBJLFsQqz5KF7KQsNORyd5/ZrSWHQRrzdo52UiFyEu2GiQ4fqRNTvAy/vwEn7i3SGZ/h+m1XGPBtQLEj/scOQZmzqD6CPKh8aL04Cr1RwC8TRcv1yvL/CZTtnv0WJLcJfARsBBgmYZDLEK8Ki3iLV7phx0axPt1tB6YxhhDAhGRQrxQzzbyVR3ioxPyztFIRJzNt/bNbgCwgeOV+Y6wVjG1BMLtV5tsZPMOWp
X-Microsoft-Antispam-PRVS: <DM2PR12MB0315BF8A67D95715C9369F8E97B50@DM2PR12MB0315.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501376)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM2PR12MB0315;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0315;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(346002)(366004)(39380400002)(396003)(47776003)(2906002)(76176011)(52146003)(52116002)(31686004)(23676004)(8936002)(65956001)(2486003)(66066001)(386003)(36756003)(65806001)(5660300001)(65826007)(86362001)(64126003)(50466002)(31696002)(956004)(476003)(6666003)(6916009)(8676002)(81166006)(54906003)(16526019)(186003)(2616005)(81156014)(6246003)(7736002)(229853002)(446003)(11346002)(478600001)(305945005)(72206003)(58126008)(6486002)(16576012)(39060400002)(53546011)(6116002)(25786009)(26005)(3846002)(53936002)(77096007)(4326008)(67846002)(230700001)(316002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0315;H:[10.129.12.246];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMzE1OzIzOjRiYWtWM0NUWlRpcEZ2TVZtNFBMend1eXNz?=
 =?utf-8?B?OVQwN3BZYTFyaEJYVUFzekNwM1JsWjdITUhkMHU5dm1va3U0MU9Sc25qOW44?=
 =?utf-8?B?YWQzQjViZmlKTFhEd2IrWnJSNzQxQ2VJNUxKTS9HTlNKOGZ5V1FqckQ5aExa?=
 =?utf-8?B?Y1IzNHlRS0oxaGRIQlZXSnNpSnNLam1tRVVSWjdDOG1nN1lzVDhtd1JMZ2pG?=
 =?utf-8?B?RG84L3lBNVpieEJvZGRGbWl1TlJhRzFWSUd2VEpjWlhwZERQZGxYN1J4K28x?=
 =?utf-8?B?K29BcS94cjlLOVFsd1hxM0VKdUorU0lwZGNjNzJjVU1MM1dGa2NDUzdjbG1Q?=
 =?utf-8?B?SEJpZW50QUExTzhDYk0rWktDRC9yWWJ3RlJ6ckNqVlZOY2RIZzMwS1NYRzFY?=
 =?utf-8?B?UnV3K1dEOTRQYTN5OFhIZzNLN2pmaDRCcG1jOUYrMGlSN3gyRzZIY0Nwd3d3?=
 =?utf-8?B?QzNUaHY0QVd6MTJIRmtvUG9lZFhUUkZ4UVFVVzAybkJNekZyZVRvSGQ0eEJT?=
 =?utf-8?B?YVlHRVpVMHRHVS9jWWdJVTgvaXhCSVQrMkRidXMvTU1vZ1dSZDJZakZ0Qm1M?=
 =?utf-8?B?OS96OFAvMlU5TytMT3VtcnVpM0N4Vlg5a3o3NVphQVFMZkpVMVdvcWsvVE1v?=
 =?utf-8?B?K1VwUUlKcTJtbkxOakpBS3N4NFF3cWxIVU9neXBTZ2VWUDE1RHpuaHRWdml5?=
 =?utf-8?B?REpTb1F1QTI5TGVVWVo0MmUrS21RVm9IdUxwNHdxM2VRSzB5ZHI0MS9FRHFw?=
 =?utf-8?B?ZU5Zb1Q0MjFGTmY1NFRTcXRBeWFlQXBJdlE3eTVPWkVlMzNLR1dxQmxRbENV?=
 =?utf-8?B?clBnTm1YQU52VUdpT2lOSkI0dDZxTWhYQ2lPQjJnbjdUVEszZVJ2Qk92aWk3?=
 =?utf-8?B?V05YTXkvR3RUTk85S2s1Ull2c09DTVU4TGVjYkxzR3dQYlJMRFZoVEZxZmZ0?=
 =?utf-8?B?ZVRDVjlaWUVzd0pNV3F3b0svMnNwaXdCRW12M3ZobG45NmRjYUFBaU9mS1ox?=
 =?utf-8?B?aVA4akFMVHVXM1Yyb1FjM01QcWpSZmhVdzM5OEJESVZWaWlmK2l6c0F5cHRB?=
 =?utf-8?B?YmZhVGxPZDIrNFNhMGFLejB6cVRycllrN1BGUHZhaWNCSUFiZEdWS0hzZlEw?=
 =?utf-8?B?Z1BjWkpDRHpDUWoydzhwUUJkblZ4d2crNDRqZ2RhYXpDL3J6VVZUb3d1MGlm?=
 =?utf-8?B?MEFmb2xVa2V4bW1PbWpYK1psUXlwN3l4bTNPellxSjA4V0RIdzhYem1qWTQw?=
 =?utf-8?B?eHo1UzhOZW12L3pUZzZrRmpaejNRaEkzaE1oUWIzaWV3Y3Iyb3lVUHhrS2k0?=
 =?utf-8?B?Z1NOSCtyWk1TRHZQeWJzT0Rwa0RJMjZyQkZUVXJNOGJhTS9GY3pBSW56bWl6?=
 =?utf-8?B?OGZEUTZObGxGM3ZWcFBRWkhsdGJqUUJuSlVzOFcwbktRMFZOSWRxeUM4ZTRE?=
 =?utf-8?B?b0MrS04rbCtSQS9yMnhIUDZZdEE2UUxTNXFnTVR1UDNTR1ZNN29JY3hkL1VS?=
 =?utf-8?B?eUtYSHR2eDVwVFpKMisvM2dvYUgyTk1TV0ZGS2ZoTGF0VUxaRW13Z0ZaRUdm?=
 =?utf-8?B?V2dJRE90bDJOa2FPSy80dzIvbDZudmh5ZEhEZlhBVWRtc0xndk40ak16OHR1?=
 =?utf-8?B?Q1k1RTZZRGtFYkZsb2RSYlg1VVBwempXNmpqZElzbCs1Rzg1S1UyZ3RsK2U5?=
 =?utf-8?B?SWZxUG84dUhZeFpuNkcraGtLK3REU2h6UWhrVDFNWVU3WVBkN3VmajJmM0Fu?=
 =?utf-8?B?TjArUjd6SFlsY2dJYjJGSTE5a0l5WmFUU0xQNEdaMTVNRmlzdnFMZjJZdUc1?=
 =?utf-8?B?SHMwOU9scTBIdGRTNDJlYTZUcVhoRFFRSGRaeHE4NlRBdUZvMEFrc2V0Z2tU?=
 =?utf-8?Q?CuRrxV0W4X4=3D?=
X-Microsoft-Antispam-Message-Info: QoM9T1JSt5ZJHLRzdvTSMcrAm1dNgliPGEqrxcFdzFUWQYJNUnV2zLBzDOqwiVxS/gqnKLOudRP9pQVHIgPgO7LZzM6VTVlbHnOPRkCMldQEFYhX1vmC+pH0JDV7WN0bSuw+pgs8LMgH7FiGkB7l8Pf34yl+g02rfF9DUo2AXKtckcX2rq+b3i0wsYD4bc6Z
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;6:lKPuVIRvvGiZz5IRdi6TdpvU547I+oxrmK8SV1y+/3HSFH0qQ6BFYRklQdBRBqyIJ4ZB0tNm7Gu53MhOBIkBlfp/NL/xvXpjsRN4XZVLWc2tedOfpz7ynNSX5ijkB1TkbcCmdYuFQie+oLve7mWLMgaz17CLPucj07V6Xk2GpP5zVB73Gj5MUmem2hUBAqsHfkxg3BaDKAyzLgyHnglNcDUGWBqmUHjlBkQocY32TmqfZmSqwXIE0xTMWtLmxbUFhp2XhyHtMrjhEHzRWMxXr4I9Si+QOvRbnodjsWd5qY3q6dOCBZqq3oq10rYXVCRMVM5td/6+98MVgj40hE1YG9bjzkXXyyvlCnQiQe9ARy30wk6hLEpYJ1rdQOY+DUfOvS841qjpPxk5cK0Yc7sKYvJsRLCFkO7qf+OkQFstkPJnJGn8FKTvvhDcIZ+gwXlSIxbTNvmVXKqnzkxHpKRUqA==;5:KhmKfASM3HXtMkyjQT3yRBH/D4umh+al/yGHz4H9g94zR8uZBdib+hNyughPyMdYF9o8UwEZH3tfinnAmADUCwgTKmh4DnFteenEImddb9cRTa9IJ3MQBcDp6PATEqeDPcYAshId9gIXE/3FQPEK72LJb3l8XULvnUL1McdzXTc=;24:WcesxSxv4rMX4fYRR0jVw82CSMXJ0WnUgYQOFX4+kGSEHxcN5ib51jhSNsZLKUVi4lItgu3rNEd3c2L2vees5WG8X3DMWarzWjorVqQ+Y1k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;7:ufnXpX1AUSAWzVdzT6YmKXu9vXxoH+J8nLP8rTs3SQgAlirYHPRv5hrxxVLmxEmgnXZ8BPGLxN/4hxFJY64DKGTKoc5gjF2kXkgqozOXf/4fOiO03Vt7dhNChuD2uyAr87J6D5YtpTgl51VSs+nmHXpA5PBLfgFTt5zF1RnBM5PRiAaFc+uqNZwgU0CqJmhvZKL9bpgr31XwU2OWj3JWLgXvThpmhS3A1tNnum9tJgnLFLQdUqYToWnafJ9LRSL0;20:yARB7HZz4yuqUvOW4MwfnSPyN3LJsa7vDfgQQVYaDPoCw1G6sODWvDqYdXEFWacd95xPBzOWc7BZ/5FljHMK+le0ngHJ7pTXrmPIeh8255lDSSK8OgdmFGw/MslruXyqlckkm3/ngbIut+5N8mRti8coxnLe/b9BpPEWDyc18zlKnvE7CCCPliW0Etn0o5Gwgeukxcs0+qYlFZGsDf9PAGjd0Jtk4i8Rz1ebKgF7hP49cy+pZT/Xys1R1Y4Re9UA
X-MS-Office365-Filtering-Correlation-Id: e8871bbd-af39-443a-20b8-08d5a5aedced
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 04:34:35.3776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8871bbd-af39-443a-20b8-08d5a5aedced
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0315
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598081599449157832?=
X-GMAIL-MSGID: =?utf-8?q?1598147771144642569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thursday 19 April 2018 05:57 AM, Daniel Kurtz wrote:
> Hi Vijendar,
> 
> On Wed, Apr 18, 2018 at 5:02 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> With in ACP, There are three I2S controllers can be
>> configured/enabled ( I2S SP, I2S MICSP, I2S BT).
>> Default enabled I2S controller instance is I2S SP.
>> This patch provides required changes to support I2S BT
>> controller Instance.
> 
> I like the direction this patch is taking, but I think it would be easier
> to review if you could split it into 2 parts:
>    (1) the cleanup of the existing driver to use a simplified flow for
> playback vs capture paths.
>    (2) adding the BT I2S channel.
> 
> 
> Thanks,
> -Dan
> 

Hi Dan,

I am fine with splitting the patch into two parts.

Thanks,
Vijendar
