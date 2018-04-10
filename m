Return-Path: <kernel-hardening-return-12955-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+6L7nYL2UgUoadVf19ecB7+4TyfPHMRWyHvZZgkhFKTOxxVvJEMKHzqBmeWa72a0QkaFRI
ARC-Seal: i=1; a=rsa-sha256; t=1523350792; cv=none;
        d=google.com; s=arc-20160816;
        b=ckQUeG2/Z94r7Qu4oUw7XSXG/sxyPol1Z2DajsA6CBJ/NKp2CvfJeBa+Yv4laBd9EA
         Q/cFX/ciPQkKSKO7mgE8+yd44ZPjtVAn2j0CwqM04CM7ZDshu9d6VIpS4B+qV/Ejqsn8
         9GX9gVl7VXbmytWVGoLEKeyExM4py2Me7IXFlxvimth7gJyJVRfahv8O4CcmSkGAMdGw
         oXtkBkVE3uYD6eehMyGrbdESrtKeoRbPBCgmPglv6scpPbqHwWVKaIhmaqOy4Sc3WIgv
         puryWAn58bMlecU4/ppVdhE/Bo3DPb2kaiR7iw6H3ZeuKiVtDnQQ/4lcQii8UTYLWC/E
         q+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=01gh8QtzlxLFhvKuTl0BSeRj+q6qfVHCeJguazpvXZQ=;
        b=Twc0n9PpsI9Bc7P602MxuzoWCLvMYDYnEmdOB8YG3ipgtGQ1s+EcLbAT94RlQDF2K3
         0dOpO+IPwyANuJYdWBfnGfW29mzkYUB4CLnhlEwNend4sJpVhg1Tn2Ukv1j7sIc0T2ty
         sQNB7qs7vrbUOPkPwGwHqA2AS42yMF5I1kRzggLnBlQHj82mWdab/+AQifxeD6l5CuW7
         JUF+egF4VHe8e4o3Ok24ZclE+mXc1DZ5u/9GZPzA1meRhUturbig2dBEfEU6vM4MCyPm
         zLTVzd8+Wfo11hUIvpT/OvBz1GRO5CSVgYGIQTa0cp1jY7+maVXMwGJWBUaI6K2lyuDn
         TbnA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=EKFuVft0;
       spf=pass (google.com: domain of kernel-hardening-return-12955-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12955-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=EKFuVft0;
       spf=pass (google.com: domain of kernel-hardening-return-12955-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12955-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] drm/amdkfd: Remove vla
To: Laura Abbott <labbott@redhat.com>, Oded Gabbay <oded.gabbay@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>
References: <20180409210620.3647-1-labbott@redhat.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <71ff5078-713c-ff8b-8c8d-6d24a7d84c02@amd.com>
Date: Tue, 10 Apr 2018 08:38:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409210620.3647-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: CWLP265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4e::23) To CY4PR12MB1718.namprd12.prod.outlook.com
 (2603:10b6:903:121::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22fae000-559a-4963-33a3-08d59eadc543
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1718;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;3:t7+6fstIICF6TjhYqjdThPgsqiA0VPZuQvFPW9BD2FoY1/7ixLR5CXAerVx4Z+LbGHHDEDtDUO+8Up55WtdUehB8Rq+jlYMvnfb+gmn+DJR0wfFwK89LmHhZbIvFPAIF4mrs7A1xL1KxC1eJszKhiJkyiH3V/D/bvf+bNukf2Qll4/JH8+6RwQ3ES1A2pVb+qD6d781OlszkCs/mM3+6ptD816igH2PVC/ylJCgQ8JC6jdErrylbFSlZEjUr3A83;25:htLR286+0bBCoM54h/2zYJeg3o7b/+AzdHWEEQUhqJSSUoK4bkHgZvMiF4pQ+oEk8Vb7U9hF0f4msrD7mmBemv4Dem7fRPr8b9zT4GSfROBhw42ndEuhTka3A/xadmeM59EP61CQigmOs6Vur545YcjfhZQkpnHYvlzPvs19xCQZz+EcudEKlNJVI8dS9jOi+F4qpWKCqf5NWUN5JB1kiIBqpfL24H0AuAYkFoA8xfZ4exPm3exauzHuTECSdDboDYvF3UDQG4c/KwL9Rx/gSOrdQoyHzgJlT+9fuTawfBpIXfPDo52dKjcmmq9YDKzWqDUDzhlCH23frNG/u0zPzg==;31:Ly2MIP67wvNOih8wpI28PF8RwKPmfYCHH8HQdrJJkd0IuMPDGmhXCeG3iMd68ZtnTTUbNvCR3J4MN+WQHeWcabHgApR4iRosVZD123rWjYbtgi95fQ9ChuZQ/nPQm8h6bxoqazTGYqPZOnylLxjKWNFxN7oUho1Wk9nWGXyH52x6eM0VYCgCryzOa5gmiE2Jnfv2z3T1gpeK0+yvXRujmz0wbsmBMU0oCixY5Z8FHyE=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1718:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;20:mTv/5xDcFtl+Gf46owEkv+3oatC/7rrflGlPknlMf/ifZTzhJ5Awa8jsnm0yJU6aMlqTFdSlQCE1O+XGnzO0V5CBj0q+M4VpQghcWTQhHnoYyQg3KJHERmmZPw3nWoyxYk2B0RfKct3/5D6noWeGRiP4B7LXO5L3Tt+k2mlF/4rCxGFx69Kt84/Yi8stF9JqatQ6dx1fMNhIkAaXjvliNXgzkozqBLsrrM1jrHrNelA0XX8kENcjlB8fBksEGZYRYG0PyS/rvKhem/iQGqJ2h7cRmVw6oFhY/ZAYlgCLDzMpXUwFfZzETZnIy86+chpDx3uIS1IZWDAl6EfCkKk7KTZz91Px7/rD5OXkSMPem+iufmLyeXHKMamBYJia/xmbH+Qs1EMwu9M++48qD2zXDhxTv41a7uO2nugY36r7WT9bi4AjvVyOVw9wcEi8+IeQX2qFkMKmm/gJcxCLCMUlFzHELHuh/HDT0bNmuURLlrJwg2fbC15iTef3iP81Abb7;4:/wK2kGvj55WX69pLY5bU9ZFRqY+uuEpIqFzwwZhk2uIaTd0Joooqfwh7Mr7zLu3IikncQh6WwXkrZwPUak7eoZXycN4+ZUieShUkpmc5Fti11PQolelZzw57r0ZtnVQg04zkWlC9bhtoryiNMgaU7Y7nW5KBVTHhIvx3t/ftAYw7w0j1wuuF5im2Emv6EqtQugxoVAP3Kr6Ds3lsB854+q4E0CdR9LnOuF2gGM9YhlXl1fZ726FOk1nKsgdqVuuyThwxAm+mAto2lj2ZcZ3HZTQ9hoAtcod9yScvDb6CNXU/XYOJu1nDba3m8x7wCCKh
X-Microsoft-Antispam-PRVS: <CY4PR12MB1718BC00B6F730002179F56A83BE0@CY4PR12MB1718.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(15185016700835);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1718;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1718;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(199004)(189003)(8676002)(110136005)(305945005)(46003)(54906003)(478600001)(11346002)(31686004)(446003)(105586002)(58126008)(86362001)(52116002)(36756003)(7736002)(47776003)(72206003)(486006)(966005)(65956001)(23676004)(8936002)(65806001)(2616005)(106356001)(64126003)(67846002)(5660300001)(6636002)(6666003)(6486002)(31696002)(230700001)(1706002)(39060400002)(386003)(316002)(65826007)(68736007)(97736004)(16526019)(186003)(6246003)(81156014)(476003)(6306002)(81166006)(2906002)(25786009)(52396003)(2486003)(52146003)(76176011)(53936002)(4326008)(229853002)(6116002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1718;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzE4OzIzOi9FQ2dkUFVvMlE4ekplUFZ3RXBVUis3K08y?=
 =?utf-8?B?Wi9rKytJMUZGSTdXdnkwbzlWcUwwa2xwemFaa09UUGlYOUVOcmN6QUgrNGZw?=
 =?utf-8?B?QTVCN0k1NDVzY0NJV3EyVThYRFAraTNONzJiVkdGMUFwak1ibVR4TVNsWDVD?=
 =?utf-8?B?ZUpGOUFVcTc1cmV2UVRYNUFmWTZXb2RXUGRwNjc4M3ZHYWdwR09YN3MyT0tv?=
 =?utf-8?B?MW9ZZ01KemQvenJxVUZOTlQyZlkvQnk3eVZvQWFrOGlCR3lIVHNEa0RMNzAx?=
 =?utf-8?B?RUdBUnFxZEgwcW9iRnh5aitPNzREdXptNGFxZTUzMWNFVnc3M0RLeFJlQmtV?=
 =?utf-8?B?eWZ5SVJyNFYzazV1R2QraGZPTE40aStQTUt2cDJxSTErSDRqNlFHSUJWb3RB?=
 =?utf-8?B?SVVPSWxjS2FocE1yM2dvd3IzK3h5c2pjRC9HUW1SR2pIZ2FqMjBZbDFDTkFQ?=
 =?utf-8?B?RG5QNXhQYi8wQndiQ2pvVUttQXZWTkx1RjhUNXE1SGRCVUExbzVscHJlYmps?=
 =?utf-8?B?OFQvNyt4VFZjdndXNXhadHFFQ0lOSUhDQTFWVEZoYWw3QTRIbmRaYmdsTTBD?=
 =?utf-8?B?SHFnWGkwaEVVOEdWczh5b2NZbjBMQ2FadjFQVGRWV0NKdVd0U1NkVkxEdS9U?=
 =?utf-8?B?cG5sUVI0OWF6RzN6SnE5NHRycUpKSmJrbjc4aFpmVENJMHp1S3ZUYWZjVC9j?=
 =?utf-8?B?aEtBenJMOEk3N2thVUN2K3I3Y2s2amtqbGhQQ0J2aGpwSW5CYktGVXU0bitF?=
 =?utf-8?B?ankrVlR2TVpyU3VFMytKVDBkWlIxQzZESEx5WW0xKzVTWG1EeGR3T1NCS0lK?=
 =?utf-8?B?SENDdXpxcnRaS25iVm00YldSWTEwOVdSVzVRNUhDNlVsMVcwdHFhR1l3ejVi?=
 =?utf-8?B?V3lHbllCclRRUGhHbGkxbklpZ2cxWTZDSTMybjc5MWNFY1ROandVbmJZUk5s?=
 =?utf-8?B?RW1kdVpyaXFEYzZTVHZ2VzhBU3hieE1PUHRqdUNkOHl6UTFvVndST2NuQ2hQ?=
 =?utf-8?B?L0xGdWJjV3p5eEpybFNCamd2RmVlbDF5WUNOSk55UEFNUk1xak1jV2g2Zzlu?=
 =?utf-8?B?UStOY2Q5aHp2ci9wYURQZ0hDbjZHNnR6ZzFrdFJGTEFyOFIvOFVzM0gzSVdk?=
 =?utf-8?B?OTlZTmp3VDd0QlJ1dzJXSjlMZ1NHckErNmJ0akkrVWR5M2hjYzBuci9hUVc3?=
 =?utf-8?B?Sm1FcEd2ZnVkSjF4NFAzSlViRUtGelg0U1JlbDVPc3JKWlF6UUU1TnB1cU5x?=
 =?utf-8?B?M0FMM3FCL05YazFrUmwrMk85Q3BOSVM5SE5tWEx5VEhUQTFnUUg4TVBDKzMx?=
 =?utf-8?B?REpiMUR0eU1KZEMrZGk1Z0NJdnl0bDNmeHFmRVUwVWtHT1JnUENWZklaRjNR?=
 =?utf-8?B?RGtzK0JuQzMwYlEyTEpJdmlLTm9PdEpXcGtSejM5bGRnZGgrOFFQbWxEd204?=
 =?utf-8?B?alIvNXNmMTA3WkgwYTV3N1ZhejVKY3UyYUN2QzhWTzhVbks0bXZva250K2Nk?=
 =?utf-8?B?azJPMnVubnRKZnEvelE1d2NWbWRXdDBJUnlqZGR3NGVZOXFlQlpMZndTSXg0?=
 =?utf-8?B?cVVmeDcxOE56MTh3VjVqdE43blFvelN0dERFZGk3ZllOZ0hIV1VXMUtDcU1K?=
 =?utf-8?B?RGpRaVZDdTFkeUhvM2dNbE45WW5Wc1VYQXVpWlJ3L05ldkpuWEZYNVlMZ2Y2?=
 =?utf-8?B?VXNPRzBYRExIam5RZmlLTzUya1Z0S3M2c1dyVGRmVXJQTUVXT09rbjkyZG8y?=
 =?utf-8?B?MlF1S0QxZFk1N1ZRaEdDSU5OSndEa2FKMEpGMEhQTGNyU2NTVkNjbXZuakxW?=
 =?utf-8?B?SG95K3lpRkdhc1l3ZFVsMlM1Q0ttMjRsQ2piNy9mbXNXNEVvQ3VlZGtyRE9N?=
 =?utf-8?B?TUw4NVh3Qk1VNFFORHFHNHR6ZVlYTGtUKzNCSGZ2UXNnaUJFWG5FMUxoNEwv?=
 =?utf-8?B?Y0w5Y3NaQ3ZQYUsxaEFKNzBqZ0JPSDBrODRTcldwbmJoZW5leGNaKytCUXZF?=
 =?utf-8?Q?5QXJ3U?=
X-Microsoft-Antispam-Message-Info: St1/aQ8uWtJ7B4NfbENRfxUmHjx/iewA44cSRSwDnni6WRza3WBHIAo0i1DfTpeK2yxE6eUbC6yNYHyXrfUUCIhAqSsZoDvTbuLNKOJtXf9gSXIz12PJBZr5a4vrvyiW8r7iF2tyaPZQitsLOHahaixQvA2NuiCXzB4lohTZGGUbkcg5qjg4yyN8T9vlt67T
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;6:oc+lUXmCrGIxpRkfyYiM+FhW7YMHWBJgGN4as/J02Jrg3OtTHH0yRV7PV6tzU514fuowyeX0XiCzBfr+Rl9f6CS7vmxsCjlItcTQ+ytB+v5gc+QO4YExw61TfqW8e95bkKpJvgzv43O14pwwoNwhyuOkPobgfMmqUVTvy96GAkfyNnwwgtNb522XXCBi783VzemgnQcyN2NZ6VlGXAiWyXvSSz5heZh6lBJDxTHWEqkbcl94rx8rYMo7jnSs65iaQynA+9qJnXKxViJrxMVEhYz5i71iAaLV5Dn2RBQ2NDQEeFojEBcoQXvfUtzsoRfwqZJQp5e+teggxVP6chsSSsCv2BY6RBoOO+DWMnGAiYIUNcyQ8fHI15TXha+I2Ul+9XNRy+1sH1eqyAhgU7bZO6jh09it92FGgHR8hNilS0hXbVk3VdaMnnMf563CeRo+wzi5Cv34iTSAKluaB7ytOw==;5:/7KbZPh6mDaxCfh7QKtEg1O6193gt1Qg0FGcuZl8LrxfiZ0Ta7AvBC1Hzidq00pArQMLGqFFfAsK4xmGaEkt0hOTTd1m5QN1AfHkmMqfuyRp+oWuzUvvSg7F7IxDmk5Z1TO2U1YdugAWy3GDNjA8HfVVuo/u7m1bjkyVWWuzZLA=;24:UMi0iaj8Jt4/qVY/oiE0cY61Y0JDniP0bS5cvVygX3aVuCAGm0d1V/nHaNKAtMujZ/vCeWGGIjEzGyRHzm5xiAXP6x9tHPmUlfqju2s8AIU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;7:nHb/nr+Mk9SYi/gr4ci71vUEGx2+pSZgAI9taCefjU6b0dLGUTi3Z8kiDUIHw3UDxI8+qglBPHnhaYcYnNxHkSkVhNXtAvxp8lDsiMR1gz2t/G4B2UxxqfpcfisjfphvtuJ/frQesKsaVKxbyAoW9STheYmAxBNHc92b0aNetYDpmL4Z5x8F4okGliLLC2EIwRH/d1d1oc9ChDzf6sqaizaOfVfGG14U+7l+EKqo9mNzcCcPWgE98okvLT4age2N;20:H8RFP5Wm6ty/7yDLdf1AqvLFbFyGFPbhl6SY68zkA3N7PPJ+FwCIYnnairok0XIvWIRYTUUcx3AlOWTbr3m7Yo45zNWanwVgbit1a/ik2v1esGjeI2lqIg7gIkUU+Q8zpAz2oYChnNUxM8Kh26BpYuQkNJ8V4kFOB0yvW3GiN7+55+uq+MKqD//uVz4dUso2B3qJ7UIOWmwWj5aWBBSGP2hIaJmXp9HIObz5uuvSuV+LcgxJfWQkHiqGOfpHHZ23
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 06:39:09.7120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fae000-559a-4963-33a3-08d59eadc543
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1718
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304222291643357?=
X-GMAIL-MSGID: =?utf-8?q?1597349080220513611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am 09.04.2018 um 23:06 schrieb Laura Abbott:
> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> turn on -Wvla. The single VLA usage in the amdkfd driver is actually
> constant across all current platforms.

Actually that isn't correct.

Could be that we haven't upstreamed KFD support for them, but Vega10 
have a different interrupt ring entry size and so would cause the error 
message here.

> Switch to a constant size array
> instead.

I would say to just make make the array bigger.

Regards,
Christian.

>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> index 035c351f47c5..c9863858f343 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> @@ -139,10 +139,12 @@ static void interrupt_wq(struct work_struct *work)
>   {
>   	struct kfd_dev *dev = container_of(work, struct kfd_dev,
>   						interrupt_work);
> +	uint32_t ih_ring_entry[4];
>   
> -	uint32_t ih_ring_entry[DIV_ROUND_UP(
> -				dev->device_info->ih_ring_entry_size,
> -				sizeof(uint32_t))];
> +	if (dev->device_info->ih_ring_entry_size > (4 * sizeof(uint32_t))) {
> +		dev_err(kfd_chardev(), "Ring entry too small\n");
> +		return;
> +	}
>   
>   	while (dequeue_ih_ring_entry(dev, ih_ring_entry))
>   		dev->device_info->event_interrupt_class->interrupt_wq(dev,
