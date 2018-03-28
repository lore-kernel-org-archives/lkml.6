Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeC1PQU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:16:20 -0400
Received: from mailout6.zih.tu-dresden.de ([141.30.67.75]:41542 "EHLO
        mailout6.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753164AbeC1PQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:16:18 -0400
Subject: Re: [RFT][PATCH v7 6/8] sched: idle: Select idle state before
 stopping the tick
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        "Aubrey Li" <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
 <2249320.0Z4q8AXauv@aspire.rjw.lan>
 <6462e44a-e207-6b97-22bf-ad4aed69afc2@tu-dresden.de>
 <4198010.6ArFqS34NK@aspire.rjw.lan>
 <CAJZ5v0j5mEaQSAiW4ynitM1ee=sqkpc8G_tZ40RYUgyavXXhqQ@mail.gmail.com>
 <b904266b-b5bb-587d-334a-844a70341f8d@tu-dresden.de>
 <CAJZ5v0iRjj5DEKU1m2_y96WRBNu6U1w=GSADRxWXfVDN9K+edQ@mail.gmail.com>
 <CAJZ5v0h40DDZ5da7CS4702Z=D3bY7SsOhbUqPR44qVKU0E4D4A@mail.gmail.com>
From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Message-ID: <ceb8f46f-6bcd-a07e-beb4-b34a9810ad8d@tu-dresden.de>
Date: Wed, 28 Mar 2018 17:15:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h40DDZ5da7CS4702Z=D3bY7SsOhbUqPR44qVKU0E4D4A@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms070709070308000805090704"
X-ClientProxiedBy: MSX-L106.msx.ad.zih.tu-dresden.de (172.26.34.106) To
 MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104)
X-PMWin-Version: 4.0.3, Antivirus-Engine: 3.70.2, Antivirus-Data: 5.49
X-TUD-Virus-Scanned: mailout6.zih.tu-dresden.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms070709070308000805090704
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-03-28 12:56, Rafael J. Wysocki wrote:
> On Wed, Mar 28, 2018 at 12:37 PM, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
>> On Wed, Mar 28, 2018 at 10:38 AM, Thomas Ilsche
>> <thomas.ilsche@tu-dresden.de> wrote:
>>> On 2018-03-28 10:13, Rafael J. Wysocki wrote:
>>>>
>=20
> [cut]
>=20
>>
>> So I do
>>
>> $ for cpu in 0 1 2 3; do taskset -c $cpu sh -c 'while true; do usleep
>> 500; done' & done
>>
>> which is a shell kind of imitation of the above and I cannot see this
>> issue at all.
>>
>> I count the number of times data->next_timer_us in menu_select() is
>> greater than TICK_USEC and while this "workload" is running, that
>> number is exactly 0.
>>
>> I'll try with a C program still.
>=20
> And with a C program I see data->next_timer_us greater than TICK_USEC
> while it is running, so let me dig deeper.
>=20

I can confirm that a shell-loop behaves differently like you describe.
Even if it's just a shell-loop calling "main{usleep(500);}" binary.


--------------ms070709070308000805090704
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EGIwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWWMIIEfqADAgECAgwcbjQkPzrYLBvMkTUwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjEyMTIxNDM5
MTZaFw0zMTAyMjIyMzU5NTlaMHMxCzAJBgNVBAYTAkRFMRAwDgYDVQQIDAdTYWNoc2VuMRAw
DgYDVQQHDAdEcmVzZGVuMSgwJgYDVQQKDB9UZWNobmlzY2hlIFVuaXZlcnNpdGFldCBEcmVz
ZGVuMRYwFAYDVQQDDA1UVSBEcmVzZGVuIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA5+CCc42Y1+0J5tpASWPSYx/0Pxqj97P1DdzCbTh3XwppRsAMtqNwS8sTxgHMmbNA
ol18t3EqIkTH/iSXEhd5cf6OSyHumVbgvZTvjMh/c7R3VGZiwqimlhk4/UJV8nVPvrL24Guk
D17Rsv+iLe5Mse7HIMJ7e9ciArdCBV5W6kk/5O24/ZhttIEs/2I3i8MTlGoBaesNgkUy/cRa
A0hw1BBTrDbfK1vhbxV/CWb+czy0F0M5W31LToGrXuwoFrhggn5X/LrFXvCb8/9w+jSk8WzG
vJw6MlPGXHwuTfjf7oei/S0j7iHq5fyIH3lEs58M4kwxlLViv2rc3KJkTX5xmQIDAQABo4IC
BTCCAgEwEgYDVR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDAN
BgsrBgEEAYGtIYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBRS/r63JMIbCh1GUo5E
JCr0SEA9ATAfBgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGE
MECgPqA8hjpodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9j
cmwvY2FjcmwuY3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290
LWcyLWNhL3B1Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcw
AYYnaHR0cDovL29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAC
hj5odHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQv
Y2FjZXJ0LmNydDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAEzY
RPywOGl/wZ/Mdz2gLDMbO39f7+iQcrVPRy/lbjjLt+0bouai8xTj1I9N+W4ZOhGww55gXMNO
nBiKouODdNcazTxW6+glA4+5K9bxkAKu9kl9J2ezpcMw1PNTFFcS1yG+thGQTtuy+3S3fI6V
Ifxi+RawFri9sC7010qS3RwOShmhsLk3iEjlDQ180zkBzsdevWHt1svALpqsc+7DcHuP+MgY
vkow/1uyHp3vyeTE9K7hdxcfXwRQ9IkeCo9xLJUeykuosqrTOQNe4Yw4hPhrJfRtoyH92SFq
deZenVeU6+rkquev61X3fPi+/ySpUOGyWPdggN65bQ81E8nLFYUwggWuMIIElqADAgECAgwc
vTmIr0re9lfFR20wDQYJKoZIhvcNAQELBQAwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1Nh
Y2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0
YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNkZW4gQ0EwHhcNMTcwMjEwMTMxMTIwWhcN
MjAwMjEwMTMxMTIwWjBdMQswCQYDVQQGEwJERTEoMCYGA1UECgwfVGVjaG5pc2NoZSBVbml2
ZXJzaXRhZXQgRHJlc2RlbjEMMAoGA1UECwwDWklIMRYwFAYDVQQDDA1UaG9tYXMgSWxzY2hl
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw5dKRIicycpBdQWviYlPQxn61uc0
dMnov1GqB3JoJpRyWICwOBn0EWcbKatI1VS6PbAbmCaXjujAZnhIppGj8NQdU15E4HaC0TDp
ucodW2vxb75srHBQ5WBwo3SDHF1gT1l6mAzr1fVddmLi2yV0kK6gaervW4gAh46l5Es6jjnp
ugT1eatFuUy2M/H/MXEeW/lWgOG3POatGOmOR/OC3c321z4OynPk2/LIEnPfrSvpCQZDrKsF
9miwvoXbkYWUAN/qhDEkyYPh/YPQ9YMg5Bgs4xz+EqEECOi8v0DWfxwgQ5zyfRW5aBj5bw0b
PLOydh4m2ufwM+Q7KQfgF04eZwIDAQABo4ICVjCCAlIwCQYDVR0TBAIwADAOBgNVHQ8BAf8E
BAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQ5omhFY59I
NNeLxf+a6i2MFhszdjAfBgNVHSMEGDAWgBRS/r63JMIbCh1GUo5EJCr0SEA9ATAmBgNVHREE
HzAdgRt0aG9tYXMuaWxzY2hlQHR1LWRyZXNkZW4uZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5
aHR0cDovL2NkcDEucGNhLmRmbi5kZS90dS1kcmVzZGVuLWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3R1LWRyZXNkZW4tZzItY2EvcHVi
L2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8v
b2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9j
ZHAxLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQw
SQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1nMi1jYS9w
dWIvY2FjZXJ0L2NhY2VydC5jcnQwQAYDVR0gBDkwNzARBg8rBgEEAYGtIYIsAQEEAwUwEQYP
KwYBBAGBrSGCLAIBBAMBMA8GDSsGAQQBga0hgiwBAQQwDQYJKoZIhvcNAQELBQADggEBACfM
PajpRlVEBvEeDqkek2aRlU1xLCR1ulK4Z8WlMN+cPnjONaEfYp3oBwqiUNKjNa4VpniQLvXM
xDWgncPOavlajnIH5urkss7iDV9ImaZEyW6sU9ZemBXGN3PP5xI1xX4dKA32N/8J57D+0Im5
I2aa6wLpeFa24qr2b5tXke77ZQwAOxp0CryiVkVP/5rp4C8D43I7x/uRhWbmxzaj+/bMwyZ0
gTsJ/k9KQaR+8oqdDn/X/PI1e7GWNykhhjG+QP1hwj2HqRRAYlTN4S3OAedvNPxtBK+28TGu
bAfD2IQZdvYAqSQT6qt2W1KkUMN38bRKdcICdqm8+fUMe7yKuvQxggO6MIIDtgIBATCBgzBz
MQswCQYDVQQGEwJERTEQMA4GA1UECAwHU2FjaHNlbjEQMA4GA1UEBwwHRHJlc2RlbjEoMCYG
A1UECgwfVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgRHJlc2RlbjEWMBQGA1UEAwwNVFUgRHJl
c2RlbiBDQQIMHL05iK9K3vZXxUdtMA0GCWCGSAFlAwQCAQUAoIICBzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAzMjgxNTE1MTFaMC8GCSqGSIb3DQEJ
BDEiBCAZwU963UEpOdkkEuyZB5xo0SAuOfhdGzXbp53vF3KauzBsBgkqhkiG9w0BCQ8xXzBd
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGUBgkrBgEEAYI3EAQx
gYYwgYMwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNk
ZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMM
DVRVIERyZXNkZW4gQ0ECDBy9OYivSt72V8VHbTCBlgYLKoZIhvcNAQkQAgsxgYaggYMwczEL
MAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNV
BAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNk
ZW4gQ0ECDBy9OYivSt72V8VHbTANBgkqhkiG9w0BAQEFAASCAQBJhFeO+WMT70SAj70sQrXE
3Ita5o5kFo75l6hmfodIVIi3LhYe/fcSHFfIUJZj3GrTJI/VUatzWtR+k5Ncn9S+zq1uK4U3
ijN5XbqF3yIYpZVXGlC98/1owhIX73GVdXtB8o1XQBxxe0NranLvORrkJrT0qBETVvmGEZm4
h1HH52PX2elR7gaDMicksrJ6uUoogNWiU8GT3HM2Itmv0ugr69Gh4pl7hKY/xCzcy3hDEnZq
BDniG8Wu/uBfOayW/c7GxaQe91025bADpgQAlp91k3nG9XXqq0i2+9sbgnOSkIn4mjSDjVX7
IRyWXLQ/sfWu2sOGG6pP69GgYaKcalJmAAAAAAAA
--------------ms070709070308000805090704--
